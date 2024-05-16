// ***************************************************************************
// ***************************************************************************
// Copyright 2014 - 2018 (c) Analog Devices, Inc. All rights reserved.
//
// In this HDL repository, there are many different and unique modules, consisting
// of various HDL (Verilog or VHDL) components. The individual modules are
// developed independently, and may be accompanied by separate and unique license
// terms.
//
// The user should read each of these license terms, and understand the
// freedoms and responsabilities that he or she has by using this source/core.
//
// This core is distributed in the hope that it will be useful, but WITHOUT ANY
// WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
// A PARTICULAR PURPOSE.
//
// Redistribution and use of source or resulting binaries, with or without modification
// of this file, are permitted under one of the following two license terms:
//
//   1. The GNU General Public License version 2 as published by the
//      Free Software Foundation, which can be found in the top level directory
//      of this repository (LICENSE_GPL2), and also online at:
//      <https://www.gnu.org/licenses/old-licenses/gpl-2.0.html>
//
// OR
//
//   2. An ADI specific BSD license, which can be found in the top level directory
//      of this repository (LICENSE_ADIBSD), and also on-line at:
//      https://github.com/analogdevicesinc/hdl/blob/master/LICENSE_ADIBSD
//      This will allow to generate bit files and not release the source code,
//      as long as it attaches to an ADI device.
//
// ***************************************************************************
// ***************************************************************************

`include "utils.svh"

package dmac_api_pkg;

  import logger_pkg::*;
  import adi_peripheral_pkg::*;
  import adi_regmap_dmac_pkg::*;
  import adi_regmap_pkg::*;
  import reg_accessor_pkg::*;
  import dma_trans_pkg::*;

  class dmac_api_base extends adi_peripheral;
    function new(
      input string name, 
      input reg_accessor bus, 
      input bit [31:0] base_address);

      super.new(name, bus, base_address);
    endfunction

    virtual task discover_params(); endtask
    virtual task probe(); endtask
    virtual task enable_dma(); endtask
    virtual task disable_dma(); endtask
    virtual task set_flags(
      input bit[2:0] flags); endtask
    virtual task wait_transfer_submission; endtask
    virtual task transfer_start; endtask
    virtual task set_dest_addr(
      input int xfer_addr); endtask
    virtual task set_src_addr(
      input int xfer_addr); endtask
    virtual task set_lengths(
      input int xfer_length_x,
      input int xfer_length_y); endtask
    virtual task wait_transfer_done(
      input bit [1:0] transfer_id,
      input bit partial_segment = 0,
      input int segment_length = 0,
      input int timeut_in_us = 2000); endtask
    virtual task transfer_id_get(output bit [1:0] transfer_id); endtask
    virtual task submit_transfer(
      dma_segment t,
      output int next_transfer_id); endtask
  endclass

  class dmac_api #(`DMAC_PARAM_DECL) extends dmac_api_base;

    // DMAC parameters
    axi_dmac_params_t p;

    adi_regmap_dmac #(
      .AXI_AXCACHE(AXI_AXCACHE),
      .AXI_AXPROT(AXI_AXPROT),
      .CACHE_COHERENT(CACHE_COHERENT),
      .CYCLIC(CYCLIC),
      .DMA_AXI_PROTOCOL_DEST(DMA_AXI_PROTOCOL_DEST),
      .DMA_AXI_PROTOCOL_SRC(DMA_AXI_PROTOCOL_SRC),
      .DMA_DATA_WIDTH_DEST(DMA_DATA_WIDTH_DEST),
      .DMA_DATA_WIDTH_SRC(DMA_DATA_WIDTH_SRC),
      .DMA_TYPE_DEST(DMA_TYPE_DEST),
      .DMA_TYPE_SRC(DMA_TYPE_SRC),
      .ID(ID),
      .MAX_BYTES_PER_BURST(MAX_BYTES_PER_BURST)
    ) regmap;

    // -----------------
    //
    // -----------------
    function new(
      input string name, 
      input reg_accessor bus, 
      input bit [31:0] base_address);
      
      super.new(name, bus, base_address);
      this.regmap = new;
    endfunction

    // -----------------
    //
    // -----------------
    // Discover HW parameters
    task discover_params();
      bit [31:0] val;
      bit  [3:0] bpb_dest_log2, bpb_src_log2, bpb_width_log2;
      // <--- begin
      // this.axi_read(GetAddrs(DMAC_PERIPHERAL_ID), val);
      // p.ID = `GET_DMAC_PERIPHERAL_ID_PERIPHERAL_ID(val);
      // ---- change
      this.axi_read(this.regmap.PERIPHERAL_ID_R);
      p.ID = this.regmap.PERIPHERAL_ID_R.PERIPHERAL_ID_F.get();
      // ---> end
      // <--- begin
      // this.axi_read(GetAddrs(DMAC_INTERFACE_DESCRIPTION), val);
      // bpb_dest_log2 = `GET_DMAC_INTERFACE_DESCRIPTION_BYTES_PER_BEAT_DEST_LOG2(val);
      // p.DMA_DATA_WIDTH_DEST = (2**bpb_dest_log2)*8;
      // p.DMA_TYPE_DEST = `GET_DMAC_INTERFACE_DESCRIPTION_DMA_TYPE_DEST(val);
      // bpb_src_log2 = `GET_DMAC_INTERFACE_DESCRIPTION_BYTES_PER_BEAT_SRC_LOG2(val);
      // p.DMA_DATA_WIDTH_SRC = (2**bpb_src_log2)*8;
      // p.DMA_TYPE_SRC = `GET_DMAC_INTERFACE_DESCRIPTION_DMA_TYPE_SRC(val);
      // bpb_width_log2 = `GET_DMAC_INTERFACE_DESCRIPTION_BYTES_PER_BURST_WIDTH(val);
      // ---- change
      this.axi_read(this.regmap.INTERFACE_DESCRIPTION_1_R);
      bpb_dest_log2 = this.regmap.INTERFACE_DESCRIPTION_1_R.BYTES_PER_BEAT_DEST_LOG2_F.get();
      p.DMA_DATA_WIDTH_DEST = (2**bpb_dest_log2)*8;
      p.DMA_TYPE_DEST = this.regmap.INTERFACE_DESCRIPTION_1_R.DMA_TYPE_DEST_F.get();
      bpb_src_log2 = this.regmap.INTERFACE_DESCRIPTION_1_R.BYTES_PER_BEAT_SRC_LOG2_F.get();
      p.DMA_DATA_WIDTH_SRC = (2**bpb_src_log2)*8;
      p.DMA_TYPE_SRC = this.regmap.INTERFACE_DESCRIPTION_1_R.DMA_TYPE_SRC_F.get();
      bpb_width_log2 = this.regmap.INTERFACE_DESCRIPTION_1_R.BYTES_PER_BURST_WIDTH_F.get();
      // ---> end
      p.MAX_BYTES_PER_BURST = 2**bpb_width_log2;
      // <--- begin
      // this.axi_write(GetAddrs(DMAC_X_LENGTH),
      //                   `SET_DMAC_X_LENGTH_X_LENGTH(32'h0));
      // ---- change
      this.regmap.X_LENGTH_R.X_LENGTH_F.set(32'h0);
      this.axi_write(this.regmap.X_LENGTH_R);
      // ---> end
      // <--- begin
      // this.axi_read(GetAddrs(DMAC_X_LENGTH), val);
      // p.DMA_LENGTH_ALIGN = `GET_DMAC_X_LENGTH_X_LENGTH(val)+1;
      // ---- change
      this.axi_read(this.regmap.X_LENGTH_R);
      p.ID = this.regmap.X_LENGTH_R.X_LENGTH_F.get()+1;
      // ---> end
      // <--- begin
      // this.axi_write(GetAddrs(DMAC_Y_LENGTH),
      //                   `SET_DMAC_Y_LENGTH_Y_LENGTH(32'hFFFFFFFF));
      // ---- change
      this.regmap.Y_LENGTH_R.Y_LENGTH_F.set(32'hFFFFFFFF);
      this.axi_write(this.regmap.Y_LENGTH_R);
      // ---> end
      // <--- begin
      // this.axi_read(GetAddrs(DMAC_Y_LENGTH), val);
      // if (val==0) begin
      //   p.DMA_2D_TRANSFER = 0;
      // end else begin 
      //   p.DMA_2D_TRANSFER = 1;
      //   this.axi_write(GetAddrs(DMAC_Y_LENGTH), 32'h0);
      // end
      // ---- change
      this.axi_read(this.regmap.Y_LENGTH_R);
      if (this.regmap.Y_LENGTH_R.Y_LENGTH_F.get()==0) begin
        p.DMA_2D_TRANSFER = 0;
      end else begin 
        p.DMA_2D_TRANSFER = 1;
        this.regmap.Y_LENGTH_R.Y_LENGTH_F.set(32'h0);
        this.axi_write(this.regmap.Y_LENGTH_R);
      end
      // ---> end
    endtask : discover_params

    // -----------------
    //
    // -----------------
    task probe ();
      super.probe();
      discover_params();
      `INFO(("Found %0s destination interface of %0d bit data width\n\t\tFound %0s source interface of %0d bit data width" ,
        p.DMA_TYPE_DEST == 0 ? "AXI MemoryMap" : p.DMA_TYPE_DEST == 1 ? "AXI Stream" : p.DMA_TYPE_DEST == 2 ? "FIFO" : "Unknown",
        p.DMA_DATA_WIDTH_DEST,
        p.DMA_TYPE_SRC == 0 ? "AXI MemoryMap" : p.DMA_TYPE_SRC == 1 ? "AXI Stream" : p.DMA_TYPE_SRC == 2 ? "FIFO" : "Unknown",
        p.DMA_DATA_WIDTH_SRC));
      `INFO(("Found %0d max bytes per burst" , p.MAX_BYTES_PER_BURST));
      `INFO(("Transfer length alignment requirement: %0d bytes" , p.DMA_LENGTH_ALIGN));
      `INFO(("Enabled support for 2D transfers: %0d" , p.DMA_2D_TRANSFER));
    endtask : probe

    // -----------------
    //
    // -----------------
    function axi_dmac_params_t get_params();
      return this.p;
    endfunction : get_params

    // -----------------
    //
    // -----------------
    task enable_dma();
      // <--- begin
      // this.axi_write(GetAddrs(DMAC_CONTROL),
      //                   `SET_DMAC_CONTROL_ENABLE(1));
      // ---- change
      this.regmap.CONTROL_R.ENABLE_F.set(1);
      this.axi_write(this.regmap.CONTROL_R);
      // ---> end
    endtask : enable_dma

    // -----------------
    //
    // -----------------
    task disable_dma();
      // <--- begin
      // this.axi_write(GetAddrs(DMAC_CONTROL),
      //                   `SET_DMAC_CONTROL_PAUSE(0));
      // ---- change
      this.regmap.CONTROL_R.PAUSE_F.set(0);
      this.axi_write(this.regmap.CONTROL_R);
      // ---> end
    endtask : disable_dma

    // -----------------
    //
    // -----------------
    task set_flags(input bit[2:0] flags);
      // <--- begin
      // this.axi_write(GetAddrs(DMAC_FLAGS),
      //                   `SET_DMAC_FLAGS_CYCLIC(flags[0])|
      //                   `SET_DMAC_FLAGS_TLAST(flags[1])|
      //                   `SET_DMAC_FLAGS_PARTIAL_REPORTING_EN(flags[2]));
      // ---- change
      this.regmap.FLAGS_R.CYCLIC_F.set(flags[0]);
      this.regmap.FLAGS_R.TLAST_F.set(flags[1]);
      this.regmap.FLAGS_R.PARTIAL_REPORTING_EN_F.set(flags[2]);
      this.axi_write(this.regmap.FLAGS_R);
      // ---> end
    endtask : set_flags

    // -----------------
    //
    // -----------------
    task wait_transfer_submission;
      // bit [31:0] regData = 'h0;
      bit timeout;

      // regData = 'h0;
      timeout = 0;
      fork
        begin
          // <--- begin
          // do
          //   this.axi_read(GetAddrs(DMAC_TRANSFER_SUBMIT), regData);
          // while (`GET_DMAC_TRANSFER_SUBMIT_TRANSFER_SUBMIT(regData) != 0);
          // ---- change
          do
            this.axi_read(this.regmap.TRANSFER_SUBMIT_R);
          while (this.regmap.TRANSFER_SUBMIT_R.TRANSFER_SUBMIT_F.get() != 0);
          // ---> end
          `INFO(("Ready for submission "));
        end
        begin
          #2ms;
          timeout = 1;
        end
      join_any
      if (timeout) begin
         `ERROR(("Waiting transfer submission TIMEOUT !!!"));
      end
    endtask : wait_transfer_submission

    // -----------------
    //
    // -----------------
    task transfer_start;
      // <--- begin
      // this.axi_write(GetAddrs(DMAC_TRANSFER_SUBMIT),
      //                   `SET_DMAC_TRANSFER_SUBMIT_TRANSFER_SUBMIT(1));
      // ---- change
      this.regmap.TRANSFER_SUBMIT_R.TRANSFER_SUBMIT_F.set(1);
      this.axi_write(this.regmap.TRANSFER_SUBMIT_R);
      // ---> end
      `INFO(("Transfer start"));
    endtask : transfer_start

    // -----------------
    //
    // -----------------
    task set_dest_addr(input int xfer_addr);
      // <--- begin
      // this.axi_write(GetAddrs(DMAC_DEST_ADDRESS),
      //                   `SET_DMAC_DEST_ADDRESS_DEST_ADDRESS(xfer_addr));
      // ---- change
      this.regmap.DEST_ADDRESS_R.DEST_ADDRESS_F.set(xfer_addr);
      this.axi_write(this.regmap.DEST_ADDRESS_R);
      // ---> end
    endtask : set_dest_addr

    // -----------------
    //
    // -----------------
    task set_src_addr(input int xfer_addr);
      // <--- begin
      // this.axi_write(GetAddrs(DMAC_SRC_ADDRESS),
      //                   `SET_DMAC_SRC_ADDRESS_SRC_ADDRESS(xfer_addr));
      // ---- change
      this.regmap.SRC_ADDRESS_R.SRC_ADDRESS_F.set(xfer_addr);
      this.axi_write(this.regmap.SRC_ADDRESS_R);
      // ---> end
    endtask : set_src_addr

    // -----------------
    //
    // -----------------
    task set_lengths(
      input int xfer_length_x,
      input int xfer_length_y);

      // <--- begin
      // this.axi_write(GetAddrs(DMAC_X_LENGTH),
      //                   `SET_DMAC_X_LENGTH_X_LENGTH(xfer_length_x));
      // ---- change
      this.regmap.X_LENGTH_R.X_LENGTH_F.set(xfer_length_x);
      this.axi_write(this.regmap.X_LENGTH_R);
      // ---> end
      // <--- begin
      // this.axi_write(GetAddrs(DMAC_Y_LENGTH),
      //                   `SET_DMAC_Y_LENGTH_Y_LENGTH(xfer_length_y));
      // ---- change
      this.regmap.Y_LENGTH_R.Y_LENGTH_F.set(xfer_length_y);
      this.axi_write(this.regmap.Y_LENGTH_R);
      // ---> end
    endtask : set_lengths

    // -----------------
    //
    // -----------------
    task wait_transfer_done(input bit [1:0] transfer_id,
                            input bit partial_segment = 0,
                            input int segment_length = 0,
                            input int timeut_in_us = 2000);
      // bit [31:0] regData = 'h0;
      bit timeout;
      int segment_length_found,id_found;
      bit partial_info_available;

      // regData = 'h0;
      timeout = 0;
      fork
        begin
          // <--- begin
          // while (~regData[transfer_id]) begin
          //   this.axi_read(GetAddrs(DMAC_TRANSFER_DONE), regData);
          // end
          // ---- change
          do
            this.axi_read(this.regmap.TRANSFER_DONE_R);
          while (~this.regmap.TRANSFER_DONE_R.value[transfer_id]);
          // ---> end
          `INFO(("Transfer id %0d DONE",transfer_id));

          // <--- begin
          // partial_info_available = `GET_DMAC_TRANSFER_DONE_PARTIAL_TRANSFER_DONE(regData);
          // ---- change
          partial_info_available = this.regmap.TRANSFER_DONE_R.PARTIAL_TRANSFER_DONE_F.get();
          // ---> end

          if (partial_segment == 1) begin
            if (partial_info_available != 1) begin
              `ERROR(("Partial transfer info availability not set for ID %0d", transfer_id));
            end

            `INFO(("Found partial data info for ID  %0d",transfer_id));
            // <--- begin
            // this.axi_read(GetAddrs(DMAC_PARTIAL_TRANSFER_LENGTH), regData);
            // segment_length_found = `GET_DMAC_PARTIAL_TRANSFER_LENGTH_PARTIAL_LENGTH(regData);
            // ---- change
            this.axi_read(this.regmap.PARTIAL_TRANSFER_LENGTH_R);
            segment_length_found = this.regmap.PARTIAL_TRANSFER_LENGTH_R.PARTIAL_LENGTH_F.get();
            // ---> end
            if (segment_length_found != segment_length) begin
              `ERROR(("Partial transfer length does not match Expected %0d Found %0d",
                      segment_length, segment_length_found));
            end else begin
              `INFO(("Found partial data info length is %0d",segment_length));
            end
            // <--- begin
            // this.axi_read(GetAddrs(DMAC_PARTIAL_TRANSFER_ID), regData);
            // id_found = `GET_DMAC_PARTIAL_TRANSFER_ID_PARTIAL_TRANSFER_ID(regData);
            // ---- change
            this.axi_read(this.regmap.PARTIAL_TRANSFER_ID_R);
            id_found = this.regmap.PARTIAL_TRANSFER_ID_R.PARTIAL_TRANSFER_ID_F.get();
            // ---> end

            if (id_found != transfer_id) begin
              `ERROR(("Partial transfer ID does not match Expected %0d Found %0d",
                      transfer_id ,id_found));
            end
          end

        end
        begin
          repeat (timeut_in_us) begin
            #1us;
          end
          timeout = 1;
        end
      join_any
      if (timeout) begin
         `ERROR(("Waiting transfer done TIMEOUT !!!"));
      end
    endtask : wait_transfer_done

    // -----------------
    //
    // -----------------
    task transfer_id_get(output bit [1:0] transfer_id);
      // <--- begin
      // this.axi_read(GetAddrs(DMAC_TRANSFER_ID), transfer_id);
      // ---- change
      this.axi_read(this.regmap.TRANSFER_ID_R);
      transfer_id = this.regmap.TRANSFER_ID_R.TRANSFER_ID_F.get();
      // ---> end
      `INFO(("Found transfer ID = %0d", transfer_id));
    endtask : transfer_id_get

    // -----------------
    //
    // -----------------
    task submit_transfer(dma_segment t,
                         output int next_transfer_id);

      dma_2d_segment t_2d;

      wait_transfer_submission();
      `INFO((" Submitting up a segment of : "));
      t.print();
      `INFO((" --------------------------"));

      if (t.length % p.DMA_LENGTH_ALIGN > 0) begin
        `ERROR(("Transfer length (%0d) must be multiple of largest interface (%0d)", t.length, p.DMA_LENGTH_ALIGN));
      end
      if (p.DMA_TYPE_SRC == 0) begin
        // <--- begin
        // this.axi_write(GetAddrs(DMAC_SRC_ADDRESS),
        //                   `SET_DMAC_SRC_ADDRESS_SRC_ADDRESS(t.src_addr));
        // ---- change
        this.regmap.SRC_ADDRESS_R.SRC_ADDRESS_F.set(t.src_addr);
        this.axi_write(this.regmap.SRC_ADDRESS_R);
        // ---> end
      end
      if (p.DMA_TYPE_DEST == 0) begin
        // <--- begin
        // this.axi_write(GetAddrs(DMAC_DEST_ADDRESS),
        //                   `SET_DMAC_DEST_ADDRESS_DEST_ADDRESS(t.dst_addr));
        // ---- change
        this.regmap.DEST_ADDRESS_R.DEST_ADDRESS_F.set(t.src_addr);
        this.axi_write(this.regmap.DEST_ADDRESS_R);
        // ---> end
      end
      // <--- begin
      // this.axi_write(GetAddrs(DMAC_X_LENGTH),
      //                   `SET_DMAC_X_LENGTH_X_LENGTH(t.length-1));
      // ---- change
      this.regmap.X_LENGTH_R.X_LENGTH_F.set(t.length-1);
      this.axi_write(this.regmap.X_LENGTH_R);
      // ---> end

      if (p.DMA_2D_TRANSFER == 1) begin
        if (!$cast(t_2d,t)) begin
          // Write the default values for 2D regs for non-2D transactions
          t_2d = new(p);
          t_2d.ylength = 1;
          t_2d.src_stride = 0;
          t_2d.dst_stride = 0;
        end
        // <--- begin
        // this.axi_write(GetAddrs(DMAC_Y_LENGTH),
        //                   `SET_DMAC_Y_LENGTH_Y_LENGTH(t_2d.ylength-1));
        // ---- change
        this.regmap.Y_LENGTH_R.Y_LENGTH_F.set(t_2d.ylength-1);
        this.axi_write(this.regmap.Y_LENGTH_R);
        // ---> end
        if (p.DMA_TYPE_SRC == 0) begin
          // <--- begin
          // this.axi_write(GetAddrs(DMAC_SRC_STRIDE),
          //                   `SET_DMAC_SRC_STRIDE_SRC_STRIDE(t_2d.src_stride));
          // ---- change
          this.regmap.SRC_STRIDE_R.SRC_STRIDE_F.set(t_2d.src_stride);
          this.axi_write(this.regmap.SRC_STRIDE_R);
          // ---> end
        end
        if (p.DMA_TYPE_DEST == 0) begin
          // <--- begin
          // this.axi_write(GetAddrs(DMAC_DEST_STRIDE),
          //                   `SET_DMAC_DEST_STRIDE_DEST_STRIDE(t_2d.dst_stride));
          // ---- change
          this.regmap.DEST_STRIDE_R.DEST_STRIDE_F.set(t_2d.src_stride);
          this.axi_write(this.regmap.DEST_STRIDE_R);
          // ---> end
        end
      end

      transfer_id_get(next_transfer_id);
      transfer_start();

    endtask : submit_transfer;
  endclass

endpackage
