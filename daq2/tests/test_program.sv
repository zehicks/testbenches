// ***************************************************************************
// ***************************************************************************
// Copyright 2014 - 2021 (c) Analog Devices, Inc. All rights reserved.
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
//
//
//
`include "utils.svh"

import test_harness_env_pkg::*;
import adi_regmap_pkg::*;
import axi_vip_pkg::*;
import axi4stream_vip_pkg::*;
import logger_pkg::*;
import adi_regmap_dmac_pkg::*;
import adi_regmap_jesd_tx_pkg::*;
import adi_regmap_jesd_rx_pkg::*;
import adi_regmap_common_pkg::*;
import adi_regmap_dac_pkg::*;
import adi_regmap_adc_pkg::*;
import adi_jesd204_pkg::*;
import adi_xcvr_pkg::*;


`define AXI_JESD_RX    32'h44aa_0000
`define AXI_JESD_TX    32'h44a9_0000

`define TX_DMA    32'h7C42_0000
`define RX_DMA    32'h7C40_0000

`define ADC_TPL    32'h44a1_0000
`define DAC_TPL    32'h44a0_4000

`define EX_ADC_TPL    32'h44A4_0000
`define EX_DAC_TPL    32'h44AB_0000

`define DUT_AXI_XCVR_RX    32'h44A5_0000
`define DUT_AXI_XCVR_TX    32'h44a6_0000

`define EX_AXI_XCVR_RX 32'h44A3_0000
`define EX_AXI_JESD_RX 32'h44A2_0000

`define EX_AXI_XCVR_TX 32'h44A8_0000
`define EX_AXI_JESD_TX 32'h44A7_0000

`define AXI_CLKGEN_TX    32'h43c0_0000
`define AXI_CLKGEN_RX    32'h43c1_0000

`define DDR_BASE 32'h44A0_0000

`define LINK_MODE 2
`define MODE_8B10B 1
`define MODE_64B66B 2

`define fmod(A, B) (A - (B * $floor(A / B)))

program test_program;

  test_harness_env env;
  bit [31:0] val;

  bit [31:0] lane_rate_khz = `LANE_RATE*1000000;
  longint lane_rate = lane_rate_khz*1000;

  int use_dds = 0;
  real rx_sysref_clk, tx_sysref_clk, common_sysref_clk;

  jesd_link tx_link;
  jesd_link rx_link;

  rx_link_layer ex_rx_ll;
  tx_link_layer ex_tx_ll;  
  xcvr ex_rx_xcvr;
  xcvr ex_tx_xcvr;  

  rx_link_layer dut_rx_ll;  
  tx_link_layer dut_tx_ll;
  xcvr dut_rx_xcvr;  
  xcvr dut_tx_xcvr;

  initial begin
    //creating environment
    env = new(`TH.`SYS_CLK.inst.IF,
              `TH.`DMA_CLK.inst.IF,
              `TH.`DDR_CLK.inst.IF,
              `TH.`MNG_AXI.inst.IF,
              `TH.`DDR_AXI.inst.IF);

    #2ps;

    setLoggerVerbosity(6);
    env.start();

    tx_link = new;
    tx_link.set_L(`TX_JESD_L);
    tx_link.set_M(`TX_JESD_M);
    tx_link.set_F(`TX_JESD_F);
    tx_link.set_S(`TX_JESD_S);
    tx_link.set_K(`TX_JESD_K);
    tx_link.set_N(`TX_JESD_NP);
    tx_link.set_NP(`TX_JESD_NP);
    tx_link.set_encoding(enc8b10b);
    tx_link.set_lane_rate(lane_rate);

    rx_link = new;
    rx_link.set_L(`RX_JESD_L);
    rx_link.set_M(`RX_JESD_M);
    rx_link.set_F(`RX_JESD_F);
    rx_link.set_S(`RX_JESD_S);
    rx_link.set_K(`RX_JESD_K);
    rx_link.set_N(`RX_JESD_NP);
    rx_link.set_NP(`RX_JESD_NP);
    rx_link.set_encoding(enc8b10b);
    rx_link.set_lane_rate(lane_rate);    

    ex_rx_ll = new("EX RX_LINK_LAYER", env.mng, `EX_AXI_JESD_RX, rx_link);
    ex_rx_ll.probe();

    ex_tx_ll = new("EX TX_LINK_LAYER", env.mng, `EX_AXI_JESD_TX, tx_link);
    ex_tx_ll.probe();    

    ex_rx_xcvr = new("EX RX_XCVR", env.mng, `EX_AXI_XCVR_RX);
    ex_rx_xcvr.probe();

    ex_tx_xcvr = new("EX TX_XCVR", env.mng, `EX_AXI_XCVR_TX);
    ex_tx_xcvr.probe();    

    dut_rx_xcvr = new("DUT RX_XCVR", env.mng, `DUT_AXI_XCVR_RX);
    dut_rx_xcvr.probe();    

    dut_tx_xcvr = new("DUT TX_XCVR", env.mng, `DUT_AXI_XCVR_TX);
    dut_tx_xcvr.probe();

    dut_rx_ll = new("DUT RX_LINK_LAYER", env.mng, `AXI_JESD_RX, rx_link);
    dut_rx_ll.probe();    

    dut_tx_ll = new("DUT TX_LINK_LAYER", env.mng, `AXI_JESD_TX, tx_link);
    dut_tx_ll.probe();

    `TH.`REF_CLK.inst.IF.set_clk_frq(.user_frequency(`REF_CLK_RATE*1000000));
    `TH.`RX_DEVICE_CLK.inst.IF.set_clk_frq(.user_frequency(ex_rx_ll.calc_device_clk()));
    `TH.`TX_DEVICE_CLK.inst.IF.set_clk_frq(.user_frequency(ex_tx_ll.calc_device_clk()));    

    rx_sysref_clk = ex_rx_ll.calc_sysref_clk();
    tx_sysref_clk = ex_tx_ll.calc_sysref_clk(); 

    $display("Printarea mea -----!!!!!!!-------");
    $display("rx_sysref_clk = %d", rx_sysref_clk);
    $display("tx_sysref_clk = %d", tx_sysref_clk);   
    
    // Add tx_os_sysref_clk logic!
//    if (tx_sysref_clk > rx_sysref_clk && `fmod(tx_sysref_clk, rx_sysref_clk) == 0)
      common_sysref_clk = rx_sysref_clk;
//    else if (tx_sysref_clk < rx_sysref_clk && `fmod(rx_sysref_clk, tx_sysref_clk) == 0) begin
//      common_sysref_clk = tx_sysref_clk;
//    end else
//      `ERROR(("RX_SYSREF_CLK and TX_SYSREF_CLK are not divisible\n RX_SYSREF_CLK: %f\n TX_SYSREF_CLK: %f", rx_sysref_clk, tx_sysref_clk));

    `TH.`SYSREF_CLK.inst.IF.set_clk_frq(.user_frequency(common_sysref_clk));

    `TH.`REF_CLK.inst.IF.start_clock;
    `TH.`RX_DEVICE_CLK.inst.IF.start_clock;
    `TH.`TX_DEVICE_CLK.inst.IF.start_clock;    
    `TH.`SYSREF_CLK.inst.IF.start_clock;

    `INFO(("pas 1 !!!!!!! ----------"));

    ex_rx_xcvr.setup_clocks(lane_rate,
                            500000000); //`REF_CLK_RATE*1000000);

     `INFO(("pas 2 !!!!!!! ----------"));

    ex_tx_xcvr.setup_clocks(lane_rate,
                            `REF_CLK_RATE*1000000);

    `INFO(("pas 3 !!!!!!! ----------"));    
    
    dut_tx_xcvr.setup_clocks(lane_rate,
                           `REF_CLK_RATE*1000000); //'{QPLL0}

    `INFO(("pas 4 !!!!!!! ----------"));

    dut_rx_xcvr.setup_clocks(lane_rate,
                            500000000); //`REF_CLK_RATE*1000000); //'{QPLL0}    
    
    `INFO(("pas 1 !!!!!!! ----------"));
    
    rx_tpl_test();

    `INFO(("======================="));
    `INFO(("  JESD LINK TEST DONE  "));
    `INFO(("======================="));


  end

  task tx_tpl_test();
    if (!use_dds) begin
      for (int i=0;i<2048*2 ;i=i+2) begin
        env.ddr_axi_agent.mem_model.backdoor_memory_write_4byte(`DDR_BASE+i*2,(((i+1)) << 16) | i ,15);
      end

      // Configure TX DMA
      env.mng.RegWrite32(`TX_DMA+GetAddrs(dmac_CONTROL),
                         `SET_dmac_CONTROL_ENABLE(1));
      env.mng.RegWrite32(`TX_DMA+GetAddrs(dmac_FLAGS),
                         `SET_dmac_FLAGS_TLAST(1));
      env.mng.RegWrite32(`TX_DMA+GetAddrs(dmac_X_LENGTH),
                         `SET_dmac_X_LENGTH_X_LENGTH(32'h00000FFF));
      env.mng.RegWrite32(`TX_DMA+GetAddrs(dmac_SRC_ADDRESS),
                         `SET_dmac_SRC_ADDRESS_SRC_ADDRESS(`DDR_BASE+32'h00000000));
      env.mng.RegWrite32(`TX_DMA+GetAddrs(dmac_TRANSFER_SUBMIT),
                         `SET_dmac_TRANSFER_SUBMIT_TRANSFER_SUBMIT(1));
      #5us;
    end

    for (int i = 0; i < `TX_JESD_M; i++) begin
      if (use_dds) begin
        // Select DDS as source
        env.mng.RegWrite32(`DAC_TPL+'h40*i+GetAddrs(DAC_CHANNEL_REG_CHAN_CNTRL_7),
                           `SET_DAC_CHANNEL_REG_CHAN_CNTRL_7_DAC_DDS_SEL(0));
        // Configure tone amplitude and frequency
        env.mng.RegWrite32(`DAC_TPL+'h40*i+GetAddrs(DAC_CHANNEL_REG_CHAN_CNTRL_1),
                           `SET_DAC_CHANNEL_REG_CHAN_CNTRL_1_DDS_SCALE_1(16'h0fff));
        env.mng.RegWrite32(`DAC_TPL+'h40*i+GetAddrs(DAC_CHANNEL_REG_CHAN_CNTRL_2),
                           `SET_DAC_CHANNEL_REG_CHAN_CNTRL_2_DDS_INCR_1(16'h0100));

      end else begin
        // Set DMA as source for DAC TPL
        env.mng.RegWrite32(`DAC_TPL+'h40*i+GetAddrs(DAC_CHANNEL_REG_CHAN_CNTRL_7),
                           `SET_DAC_CHANNEL_REG_CHAN_CNTRL_7_DAC_DDS_SEL(2));
      end
    end

    for (int i = 0; i < `TX_JESD_M; i++) begin
      env.mng.RegWrite32(`EX_ADC_TPL+'h40*i+GetAddrs(ADC_CHANNEL_REG_CHAN_CNTRL),
                         `SET_ADC_CHANNEL_REG_CHAN_CNTRL_ENABLE(1));
    end


    env.mng.RegWrite32(`DAC_TPL+GetAddrs(DAC_COMMON_REG_RSTN),
                       `SET_DAC_COMMON_REG_RSTN_RSTN(1));
    env.mng.RegWrite32(`EX_ADC_TPL+GetAddrs(ADC_COMMON_REG_RSTN),
                       `SET_ADC_COMMON_REG_RSTN_RSTN(1));

    if (use_dds) begin
      // Sync DDS cores
      env.mng.RegWrite32(`DAC_TPL+GetAddrs(DAC_COMMON_REG_CNTRL_1),
                         `SET_DAC_COMMON_REG_CNTRL_1_SYNC(1));
    end

    // -----------------------
    // bringup DUT TX path
    // -----------------------
    env.mng.RegWrite32(`AXI_CLKGEN_TX + 'h40, 3);
    dut_tx_xcvr.up();
    dut_tx_ll.link_up();

    ex_rx_xcvr.up();
    ex_rx_ll.link_up();

    dut_tx_ll.wait_link_up();
    ex_rx_ll.wait_link_up();

    #10us;
    
    ex_rx_xcvr.down();
    dut_tx_xcvr.down();
  endtask
 
  task rx_tpl_test();
    for (int i = 0; i < `RX_JESD_M; i++) begin
      if (use_dds) begin
        // Select DDS as source
        env.mng.RegWrite32(`EX_DAC_TPL+'h40*i+GetAddrs(DAC_CHANNEL_REG_CHAN_CNTRL_7),
                           `SET_DAC_CHANNEL_REG_CHAN_CNTRL_7_DAC_DDS_SEL(0));
        // Configure tone amplitude and frequency
        env.mng.RegWrite32(`EX_DAC_TPL+'h40*i+GetAddrs(DAC_CHANNEL_REG_CHAN_CNTRL_1),
                           `SET_DAC_CHANNEL_REG_CHAN_CNTRL_1_DDS_SCALE_1(16'h0fff));
        env.mng.RegWrite32(`EX_DAC_TPL+'h40*i+GetAddrs(DAC_CHANNEL_REG_CHAN_CNTRL_2),
                           `SET_DAC_CHANNEL_REG_CHAN_CNTRL_2_DDS_INCR_1(16'h0100));

      end else begin
        // Set DMA as source for DAC TPL
        env.mng.RegWrite32(`EX_DAC_TPL+'h40*i+GetAddrs(DAC_CHANNEL_REG_CHAN_CNTRL_7),
                           `SET_DAC_CHANNEL_REG_CHAN_CNTRL_7_DAC_DDS_SEL(2));
      end
    end

    for (int i = 0; i < `RX_JESD_M; i++) begin
      env.mng.RegWrite32(`ADC_TPL+'h40*i+GetAddrs(ADC_CHANNEL_REG_CHAN_CNTRL),
                         `SET_ADC_CHANNEL_REG_CHAN_CNTRL_ENABLE(1));
    end

    env.mng.RegWrite32(`EX_DAC_TPL+GetAddrs(DAC_COMMON_REG_RSTN),
                       `SET_DAC_COMMON_REG_RSTN_RSTN(1));
    env.mng.RegWrite32(`ADC_TPL+GetAddrs(ADC_COMMON_REG_RSTN),
                       `SET_ADC_COMMON_REG_RSTN_RSTN(1));
    
    // -----------------------
    // bringup DUT RX path
    // -----------------------
    env.mng.RegWrite32(`AXI_CLKGEN_RX + 'h40, 3);
    ex_tx_xcvr.up();
    ex_tx_ll.link_up();

    dut_rx_xcvr.up();
    dut_rx_ll.link_up();

    ex_tx_ll.wait_link_up();
    dut_rx_ll.wait_link_up();

    #10us;
    
    // Configure RX DMA
    if (!use_dds) begin
      env.mng.RegWrite32(`RX_DMA+GetAddrs(dmac_CONTROL),
                         `SET_dmac_CONTROL_ENABLE(1));
      env.mng.RegWrite32(`RX_DMA+GetAddrs(dmac_FLAGS),
                         `SET_dmac_FLAGS_TLAST(1));
      env.mng.RegWrite32(`RX_DMA+GetAddrs(dmac_X_LENGTH),
                         `SET_dmac_X_LENGTH_X_LENGTH(32'h000003DF));
      env.mng.RegWrite32(`RX_DMA+GetAddrs(dmac_DEST_ADDRESS),
                         `SET_dmac_DEST_ADDRESS_DEST_ADDRESS(`DDR_BASE+32'h00001000));
      env.mng.RegWrite32(`RX_DMA+GetAddrs(dmac_TRANSFER_SUBMIT),
                         `SET_dmac_TRANSFER_SUBMIT_TRANSFER_SUBMIT(1));
  
      #5us;
  
      check_captured_data(
        .address (`DDR_BASE+'h00001000),
        .length (992),
        .step (1),
        .max_sample(2048),
        .num_of_converters(`RX_JESD_M)
      );
      
      #10us;
    end

    dut_rx_xcvr.down();
    ex_tx_xcvr.down();

  endtask

  task check_captured_data(bit [31:0] address,
                           int length = 1024,
                           int step = 1,
                           int max_sample = 2048,
                           int num_of_converters = 4
                          );

    bit [31:0] current_address;
    bit [31:0] captured_word;
    bit [31:0] reference_word;
    bit [7:0] first, second;

    for (int i=0;i<length/2;i=i+2) begin
      current_address = address+(i*2);
      captured_word = env.ddr_axi_agent.mem_model.backdoor_memory_read_4byte(current_address);
      if (i==0) begin
        first = captured_word[15:8];
        second = captured_word[7:0];
      end else begin
        reference_word = {(first + 8'h10), second, first, second};

        if (captured_word !== reference_word) begin
          `ERROR(("Address 0x%h Expected 0x%h found 0x%h",current_address,reference_word,captured_word));
        end
      end
      
      first = (first + 8'h20);
      if (first[7:4] >= num_of_converters) begin
        first = 8'h00;
        second = second + 1'h1;
      end

    end
  endtask

endprogram