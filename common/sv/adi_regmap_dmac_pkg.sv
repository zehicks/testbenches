// ***************************************************************************
// ***************************************************************************
// Copyright 2014 - 2024 (c) Analog Devices, Inc. All rights reserved.
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
//      https://github.com/analogdevicesinc/hdl/blob/main/LICENSE_ADIBSD
//      This will allow to generate bit files and not release the source code,
//      as long as it attaches to an ADI device.
//
// ***************************************************************************
// ***************************************************************************
/* Auto generated Register Map */
/* May 14 13:17:22 2024 */

package adi_regmap_dmac_pkg;
  import regmap_pkg::*;

  class adi_regmap_dmac #(int AXI_AXCACHE, int AXI_AXPROT, int BYTES_PER_BURST_WIDTH, int CACHE_COHERENT, int CYCLIC, int DMA_DATA_WIDTH_DEST, int DMA_DATA_WIDTH_SRC, int DMA_TYPE_DEST, int DMA_TYPE_SRC, int ID);

    /* DMA Controller (axi_dmac) */
    class VERSION extends register_base;
      field_base VERSION_MAJOR_F;
      field_base VERSION_MINOR_F;
      field_base VERSION_PATCH_F;

      function new(
        input string name,
        input int address);

        super.new(name, address);
        this.VERSION_MAJOR_F = new("VERSION_MAJOR", 31, 16, RO, 'h4, this);
        this.VERSION_MINOR_F = new("VERSION_MINOR", 15, 8, RO, 'h5, this);
        this.VERSION_PATCH_F = new("VERSION_PATCH", 7, 0, RO, 'h62, this);
      endfunction: new
    endclass

    class PERIPHERAL_ID #(int ID) extends register_base;
      field_base PERIPHERAL_ID_F;

      function new(
        input string name,
        input int address);

        super.new(name, address);
        this.PERIPHERAL_ID_F = new("PERIPHERAL_ID", 31, 0, RO, ID, this);
      endfunction: new
    endclass

    class SCRATCH extends register_base;
      field_base SCRATCH_F;

      function new(
        input string name,
        input int address);

        super.new(name, address);
        this.SCRATCH_F = new("SCRATCH", 31, 0, RW, 'h0, this);
      endfunction: new
    endclass

    class IDENTIFICATION extends register_base;
      field_base IDENTIFICATION_F;

      function new(
        input string name,
        input int address);

        super.new(name, address);
        this.IDENTIFICATION_F = new("IDENTIFICATION", 31, 0, RO, 'h444d4143, this);
      endfunction: new
    endclass

    class INTERFACE_DESCRIPTION_1 #(int BYTES_PER_BURST_WIDTH, int DMA_DATA_WIDTH_DEST, int DMA_DATA_WIDTH_SRC, int DMA_TYPE_DEST, int DMA_TYPE_SRC) extends register_base;
      field_base BYTES_PER_BEAT_DEST_LOG2_F;
      field_base DMA_TYPE_DEST_F;
      field_base BYTES_PER_BEAT_SRC_LOG2_F;
      field_base DMA_TYPE_SRC_F;
      field_base BYTES_PER_BURST_WIDTH_F;

      function new(
        input string name,
        input int address);

        super.new(name, address);
        this.BYTES_PER_BEAT_DEST_LOG2_F = new("BYTES_PER_BEAT_DEST_LOG2", 3, 0, RO, $clog2(DMA_DATA_WIDTH_DEST/8), this);
        this.DMA_TYPE_DEST_F = new("DMA_TYPE_DEST", 5, 4, RO, DMA_TYPE_DEST, this);
        this.BYTES_PER_BEAT_SRC_LOG2_F = new("BYTES_PER_BEAT_SRC_LOG2", 11, 8, RO, $clog2(DMA_DATA_WIDTH_SRC/8), this);
        this.DMA_TYPE_SRC_F = new("DMA_TYPE_SRC", 13, 12, RO, DMA_TYPE_SRC, this);
        this.BYTES_PER_BURST_WIDTH_F = new("BYTES_PER_BURST_WIDTH", 19, 16, RO, BYTES_PER_BURST_WIDTH, this);
      endfunction: new
    endclass

    class INTERFACE_DESCRIPTION_2 #(int AXI_AXCACHE, int AXI_AXPROT, int CACHE_COHERENT) extends register_base;
      field_base CACHE_COHERENT_F;
      field_base AXI_AXCACHE_F;
      field_base AXI_AXPROT_F;

      function new(
        input string name,
        input int address);

        super.new(name, address);
        this.CACHE_COHERENT_F = new("CACHE_COHERENT", 0, 0, RO, CACHE_COHERENT, this);
        this.AXI_AXCACHE_F = new("AXI_AXCACHE", 7, 4, RO, AXI_AXCACHE, this);
        this.AXI_AXPROT_F = new("AXI_AXPROT", 10, 8, RO, AXI_AXPROT, this);
      endfunction: new
    endclass

    class IRQ_MASK extends register_base;
      field_base TRANSFER_COMPLETED_F;
      field_base TRANSFER_QUEUED_F;

      function new(
        input string name,
        input int address);

        super.new(name, address);
        this.TRANSFER_COMPLETED_F = new("TRANSFER_COMPLETED", 1, 1, RW, 'h1, this);
        this.TRANSFER_QUEUED_F = new("TRANSFER_QUEUED", 0, 0, RW, 'h1, this);
      endfunction: new
    endclass

    class IRQ_PENDING extends register_base;
      field_base TRANSFER_COMPLETED_F;
      field_base TRANSFER_QUEUED_F;

      function new(
        input string name,
        input int address);

        super.new(name, address);
        this.TRANSFER_COMPLETED_F = new("TRANSFER_COMPLETED", 1, 1, RW1C, 'h0, this);
        this.TRANSFER_QUEUED_F = new("TRANSFER_QUEUED", 0, 0, RW1C, 'h0, this);
      endfunction: new
    endclass

    class IRQ_SOURCE extends register_base;
      field_base TRANSFER_COMPLETED_F;
      field_base TRANSFER_QUEUED_F;

      function new(
        input string name,
        input int address);

        super.new(name, address);
        this.TRANSFER_COMPLETED_F = new("TRANSFER_COMPLETED", 1, 1, RO, 'h0, this);
        this.TRANSFER_QUEUED_F = new("TRANSFER_QUEUED", 0, 0, RO, 'h0, this);
      endfunction: new
    endclass

    class CONTROL extends register_base;
      field_base HWDESC_F;
      field_base PAUSE_F;
      field_base ENABLE_F;

      function new(
        input string name,
        input int address);

        super.new(name, address);
        this.HWDESC_F = new("HWDESC", 2, 2, RW, 'h0, this);
        this.PAUSE_F = new("PAUSE", 1, 1, RW, 'h0, this);
        this.ENABLE_F = new("ENABLE", 0, 0, RW, 'h0, this);
      endfunction: new
    endclass

    class TRANSFER_ID extends register_base;
      field_base TRANSFER_ID_F;

      function new(
        input string name,
        input int address);

        super.new(name, address);
        this.TRANSFER_ID_F = new("TRANSFER_ID", 1, 0, RO, 'h0, this);
      endfunction: new
    endclass

    class TRANSFER_SUBMIT extends register_base;
      field_base TRANSFER_SUBMIT_F;

      function new(
        input string name,
        input int address);

        super.new(name, address);
        this.TRANSFER_SUBMIT_F = new("TRANSFER_SUBMIT", 0, 0, RW, 'h0, this);
      endfunction: new
    endclass

    class FLAGS #(int CYCLIC) extends register_base;
      field_base CYCLIC_F;
      field_base TLAST_F;
      field_base PARTIAL_REPORTING_EN_F;

      function new(
        input string name,
        input int address);

        super.new(name, address);
        this.CYCLIC_F = new("CYCLIC", 0, 0, RW, CYCLIC, this);
        this.TLAST_F = new("TLAST", 1, 1, RW, 'h1, this);
        this.PARTIAL_REPORTING_EN_F = new("PARTIAL_REPORTING_EN", 2, 2, RW, 'h0, this);
      endfunction: new
    endclass

    class DEST_ADDRESS extends register_base;
      field_base DEST_ADDRESS_F;

      function new(
        input string name,
        input int address);

        super.new(name, address);
        this.DEST_ADDRESS_F = new("DEST_ADDRESS", 31, 0, RW, 'h0, this);
      endfunction: new
    endclass

    class SRC_ADDRESS extends register_base;
      field_base SRC_ADDRESS_F;

      function new(
        input string name,
        input int address);

        super.new(name, address);
        this.SRC_ADDRESS_F = new("SRC_ADDRESS", 31, 0, RW, 'h0, this);
      endfunction: new
    endclass

    class X_LENGTH #(int DMA_DATA_WIDTH_DEST, int DMA_DATA_WIDTH_SRC) extends register_base;
      field_base X_LENGTH_F;

      function new(
        input string name,
        input int address);

        super.new(name, address);
        this.X_LENGTH_F = new("X_LENGTH", 23, 0, RW, 2**$clog2(`MAX(DMA_DATA_WIDTH_SRC, DMA_DATA_WIDTH_DEST)/8)-1, this);
      endfunction: new
    endclass

    class Y_LENGTH extends register_base;
      field_base Y_LENGTH_F;

      function new(
        input string name,
        input int address);

        super.new(name, address);
        this.Y_LENGTH_F = new("Y_LENGTH", 23, 0, RW, 'h0, this);
      endfunction: new
    endclass

    class DEST_STRIDE extends register_base;
      field_base DEST_STRIDE_F;

      function new(
        input string name,
        input int address);

        super.new(name, address);
        this.DEST_STRIDE_F = new("DEST_STRIDE", 23, 0, RW, 'h0, this);
      endfunction: new
    endclass

    class SRC_STRIDE extends register_base;
      field_base SRC_STRIDE_F;

      function new(
        input string name,
        input int address);

        super.new(name, address);
        this.SRC_STRIDE_F = new("SRC_STRIDE", 23, 0, RW, 'h0, this);
      endfunction: new
    endclass

    class TRANSFER_DONE extends register_base;
      field_base TRANSFER_0_DONE_F;
      field_base TRANSFER_1_DONE_F;
      field_base TRANSFER_2_DONE_F;
      field_base TRANSFER_3_DONE_F;
      field_base PARTIAL_TRANSFER_DONE_F;

      function new(
        input string name,
        input int address);

        super.new(name, address);
        this.TRANSFER_0_DONE_F = new("TRANSFER_0_DONE", 0, 0, RO, 'h0, this);
        this.TRANSFER_1_DONE_F = new("TRANSFER_1_DONE", 1, 1, RO, 'h0, this);
        this.TRANSFER_2_DONE_F = new("TRANSFER_2_DONE", 2, 2, RO, 'h0, this);
        this.TRANSFER_3_DONE_F = new("TRANSFER_3_DONE", 3, 3, RO, 'h0, this);
        this.PARTIAL_TRANSFER_DONE_F = new("PARTIAL_TRANSFER_DONE", 31, 31, RO, 'h0, this);
      endfunction: new
    endclass

    class ACTIVE_TRANSFER_ID extends register_base;
      field_base ACTIVE_TRANSFER_ID_F;

      function new(
        input string name,
        input int address);

        super.new(name, address);
        this.ACTIVE_TRANSFER_ID_F = new("ACTIVE_TRANSFER_ID", 4, 0, RO, 'h0, this);
      endfunction: new
    endclass

    class STATUS extends register_base;

      function new(
        input string name,
        input int address);

        super.new(name, address);
      endfunction: new
    endclass

    class CURRENT_DEST_ADDRESS extends register_base;
      field_base CURRENT_DEST_ADDRESS_F;

      function new(
        input string name,
        input int address);

        super.new(name, address);
        this.CURRENT_DEST_ADDRESS_F = new("CURRENT_DEST_ADDRESS", 31, 0, RO, 'h0, this);
      endfunction: new
    endclass

    class CURRENT_SRC_ADDRESS extends register_base;
      field_base CURRENT_SRC_ADDRESS_F;

      function new(
        input string name,
        input int address);

        super.new(name, address);
        this.CURRENT_SRC_ADDRESS_F = new("CURRENT_SRC_ADDRESS", 31, 0, RO, 'h0, this);
      endfunction: new
    endclass

    class TRANSFER_PROGRESS extends register_base;
      field_base TRANSFER_PROGRESS_F;

      function new(
        input string name,
        input int address);

        super.new(name, address);
        this.TRANSFER_PROGRESS_F = new("TRANSFER_PROGRESS", 23, 0, RO, 'h0, this);
      endfunction: new
    endclass

    class PARTIAL_TRANSFER_LENGTH extends register_base;
      field_base PARTIAL_LENGTH_F;

      function new(
        input string name,
        input int address);

        super.new(name, address);
        this.PARTIAL_LENGTH_F = new("PARTIAL_LENGTH", 31, 0, RO, 'h0, this);
      endfunction: new
    endclass

    class PARTIAL_TRANSFER_ID extends register_base;
      field_base PARTIAL_TRANSFER_ID_F;

      function new(
        input string name,
        input int address);

        super.new(name, address);
        this.PARTIAL_TRANSFER_ID_F = new("PARTIAL_TRANSFER_ID", 1, 0, RO, 'h0, this);
      endfunction: new
    endclass

    class DESCRIPTOR_ID extends register_base;
      field_base DESCRIPTOR_ID_F;

      function new(
        input string name,
        input int address);

        super.new(name, address);
        this.DESCRIPTOR_ID_F = new("DESCRIPTOR_ID", 31, 0, RO, 'h0, this);
      endfunction: new
    endclass

    class SG_ADDRESS extends register_base;
      field_base SG_ADDRESS_F;

      function new(
        input string name,
        input int address);

        super.new(name, address);
        this.SG_ADDRESS_F = new("SG_ADDRESS", 31, 0, RW, 'h0, this);
      endfunction: new
    endclass

    class DEST_ADDRESS_HIGH extends register_base;
      field_base DEST_ADDRESS_HIGH_F;

      function new(
        input string name,
        input int address);

        super.new(name, address);
        this.DEST_ADDRESS_HIGH_F = new("DEST_ADDRESS_HIGH", 31, 0, RW, 'h0, this);
      endfunction: new
    endclass

    class SRC_ADDRESS_HIGH extends register_base;
      field_base SRC_ADDRESS_HIGH_F;

      function new(
        input string name,
        input int address);

        super.new(name, address);
        this.SRC_ADDRESS_HIGH_F = new("SRC_ADDRESS_HIGH", 31, 0, RW, 'h0, this);
      endfunction: new
    endclass

    class CURRENT_DEST_ADDRESS_HIGH extends register_base;
      field_base CURRENT_DEST_ADDRESS_HIGH_F;

      function new(
        input string name,
        input int address);

        super.new(name, address);
        this.CURRENT_DEST_ADDRESS_HIGH_F = new("CURRENT_DEST_ADDRESS_HIGH", 31, 0, RO, 'h0, this);
      endfunction: new
    endclass

    class CURRENT_SRC_ADDRESS_HIGH extends register_base;
      field_base CURRENT_SRC_ADDRESS_HIGH_F;

      function new(
        input string name,
        input int address);

        super.new(name, address);
        this.CURRENT_SRC_ADDRESS_HIGH_F = new("CURRENT_SRC_ADDRESS_HIGH", 31, 0, RO, 'h0, this);
      endfunction: new
    endclass

    class SG_ADDRESS_HIGH extends register_base;
      field_base SG_ADDRESS_HIGH_F;

      function new(
        input string name,
        input int address);

        super.new(name, address);
        this.SG_ADDRESS_HIGH_F = new("SG_ADDRESS_HIGH", 31, 0, RW, 'h0, this);
      endfunction: new
    endclass

    VERSION VERSION_R;
    PERIPHERAL_ID #(ID) PERIPHERAL_ID_R;
    SCRATCH SCRATCH_R;
    IDENTIFICATION IDENTIFICATION_R;
    INTERFACE_DESCRIPTION_1 #(BYTES_PER_BURST_WIDTH, DMA_DATA_WIDTH_DEST, DMA_DATA_WIDTH_SRC, DMA_TYPE_DEST, DMA_TYPE_SRC) INTERFACE_DESCRIPTION_1_R;
    INTERFACE_DESCRIPTION_2 #(AXI_AXCACHE, AXI_AXPROT, CACHE_COHERENT) INTERFACE_DESCRIPTION_2_R;
    IRQ_MASK IRQ_MASK_R;
    IRQ_PENDING IRQ_PENDING_R;
    IRQ_SOURCE IRQ_SOURCE_R;
    CONTROL CONTROL_R;
    TRANSFER_ID TRANSFER_ID_R;
    TRANSFER_SUBMIT TRANSFER_SUBMIT_R;
    FLAGS #(CYCLIC) FLAGS_R;
    DEST_ADDRESS DEST_ADDRESS_R;
    SRC_ADDRESS SRC_ADDRESS_R;
    X_LENGTH #(DMA_DATA_WIDTH_DEST, DMA_DATA_WIDTH_SRC) X_LENGTH_R;
    Y_LENGTH Y_LENGTH_R;
    DEST_STRIDE DEST_STRIDE_R;
    SRC_STRIDE SRC_STRIDE_R;
    TRANSFER_DONE TRANSFER_DONE_R;
    ACTIVE_TRANSFER_ID ACTIVE_TRANSFER_ID_R;
    STATUS STATUS_R;
    CURRENT_DEST_ADDRESS CURRENT_DEST_ADDRESS_R;
    CURRENT_SRC_ADDRESS CURRENT_SRC_ADDRESS_R;
    TRANSFER_PROGRESS TRANSFER_PROGRESS_R;
    PARTIAL_TRANSFER_LENGTH PARTIAL_TRANSFER_LENGTH_R;
    PARTIAL_TRANSFER_ID PARTIAL_TRANSFER_ID_R;
    DESCRIPTOR_ID DESCRIPTOR_ID_R;
    SG_ADDRESS SG_ADDRESS_R;
    DEST_ADDRESS_HIGH DEST_ADDRESS_HIGH_R;
    SRC_ADDRESS_HIGH SRC_ADDRESS_HIGH_R;
    CURRENT_DEST_ADDRESS_HIGH CURRENT_DEST_ADDRESS_HIGH_R;
    CURRENT_SRC_ADDRESS_HIGH CURRENT_SRC_ADDRESS_HIGH_R;
    SG_ADDRESS_HIGH SG_ADDRESS_HIGH_R;

    function new();
      this.VERSION_R = new("VERSION", 'h0);
      this.PERIPHERAL_ID_R = new("PERIPHERAL_ID", 'h4);
      this.SCRATCH_R = new("SCRATCH", 'h8);
      this.IDENTIFICATION_R = new("IDENTIFICATION", 'hc);
      this.INTERFACE_DESCRIPTION_1_R = new("INTERFACE_DESCRIPTION_1", 'h10);
      this.INTERFACE_DESCRIPTION_2_R = new("INTERFACE_DESCRIPTION_2", 'h14);
      this.IRQ_MASK_R = new("IRQ_MASK", 'h80);
      this.IRQ_PENDING_R = new("IRQ_PENDING", 'h84);
      this.IRQ_SOURCE_R = new("IRQ_SOURCE", 'h88);
      this.CONTROL_R = new("CONTROL", 'h400);
      this.TRANSFER_ID_R = new("TRANSFER_ID", 'h404);
      this.TRANSFER_SUBMIT_R = new("TRANSFER_SUBMIT", 'h408);
      this.FLAGS_R = new("FLAGS", 'h40c);
      this.DEST_ADDRESS_R = new("DEST_ADDRESS", 'h410);
      this.SRC_ADDRESS_R = new("SRC_ADDRESS", 'h414);
      this.X_LENGTH_R = new("X_LENGTH", 'h418);
      this.Y_LENGTH_R = new("Y_LENGTH", 'h41c);
      this.DEST_STRIDE_R = new("DEST_STRIDE", 'h420);
      this.SRC_STRIDE_R = new("SRC_STRIDE", 'h424);
      this.TRANSFER_DONE_R = new("TRANSFER_DONE", 'h428);
      this.ACTIVE_TRANSFER_ID_R = new("ACTIVE_TRANSFER_ID", 'h42c);
      this.STATUS_R = new("STATUS", 'h430);
      this.CURRENT_DEST_ADDRESS_R = new("CURRENT_DEST_ADDRESS", 'h434);
      this.CURRENT_SRC_ADDRESS_R = new("CURRENT_SRC_ADDRESS", 'h438);
      this.TRANSFER_PROGRESS_R = new("TRANSFER_PROGRESS", 'h448);
      this.PARTIAL_TRANSFER_LENGTH_R = new("PARTIAL_TRANSFER_LENGTH", 'h44c);
      this.PARTIAL_TRANSFER_ID_R = new("PARTIAL_TRANSFER_ID", 'h450);
      this.DESCRIPTOR_ID_R = new("DESCRIPTOR_ID", 'h454);
      this.SG_ADDRESS_R = new("SG_ADDRESS", 'h47c);
      this.DEST_ADDRESS_HIGH_R = new("DEST_ADDRESS_HIGH", 'h490);
      this.SRC_ADDRESS_HIGH_R = new("SRC_ADDRESS_HIGH", 'h494);
      this.CURRENT_DEST_ADDRESS_HIGH_R = new("CURRENT_DEST_ADDRESS_HIGH", 'h498);
      this.CURRENT_SRC_ADDRESS_HIGH_R = new("CURRENT_SRC_ADDRESS_HIGH", 'h49c);
      this.SG_ADDRESS_HIGH_R = new("SG_ADDRESS_HIGH", 'h4bc);
    endfunction: new;

  endclass;
endpackage;
