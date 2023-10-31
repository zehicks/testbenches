// ***************************************************************************
// ***************************************************************************
// Copyright 2014 - 2023 (c) Analog Devices, Inc. All rights reserved.
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
/* Auto generated Register Map */
/* Tue Oct 31 12:47:12 2023 */

package adi_regmap_dmac_pkg;
  import adi_regmap_pkg::*;


/* DMA Controller (axi_dmac) */

  const reg_t DMAC_VERSION = '{ 'h0000, "VERSION" , '{
    "VERSION_MAJOR": '{ 31, 16, RO, 'h04 },
    "VERSION_MINOR": '{ 15, 8, RO, 'h05 },
    "VERSION_PATCH": '{ 7, 0, RO, 'h61 }}};
  `define SET_DMAC_VERSION_VERSION_MAJOR(x) SetField(DMAC_VERSION,"VERSION_MAJOR",x)
  `define GET_DMAC_VERSION_VERSION_MAJOR(x) GetField(DMAC_VERSION,"VERSION_MAJOR",x)
  `define SET_DMAC_VERSION_VERSION_MINOR(x) SetField(DMAC_VERSION,"VERSION_MINOR",x)
  `define GET_DMAC_VERSION_VERSION_MINOR(x) GetField(DMAC_VERSION,"VERSION_MINOR",x)
  `define SET_DMAC_VERSION_VERSION_PATCH(x) SetField(DMAC_VERSION,"VERSION_PATCH",x)
  `define GET_DMAC_VERSION_VERSION_PATCH(x) GetField(DMAC_VERSION,"VERSION_PATCH",x)

  const reg_t DMAC_PERIPHERAL_ID = '{ 'h0004, "PERIPHERAL_ID" , '{
    "PERIPHERAL_ID": '{ 31, 0, RO, 0 }}};
  `define SET_DMAC_PERIPHERAL_ID_PERIPHERAL_ID(x) SetField(DMAC_PERIPHERAL_ID,"PERIPHERAL_ID",x)
  `define GET_DMAC_PERIPHERAL_ID_PERIPHERAL_ID(x) GetField(DMAC_PERIPHERAL_ID,"PERIPHERAL_ID",x)

  const reg_t DMAC_SCRATCH = '{ 'h0008, "SCRATCH" , '{
    "SCRATCH": '{ 31, 0, RW, 'h00000000 }}};
  `define SET_DMAC_SCRATCH_SCRATCH(x) SetField(DMAC_SCRATCH,"SCRATCH",x)
  `define GET_DMAC_SCRATCH_SCRATCH(x) GetField(DMAC_SCRATCH,"SCRATCH",x)

  const reg_t DMAC_IDENTIFICATION = '{ 'h000c, "IDENTIFICATION" , '{
    "IDENTIFICATION": '{ 31, 0, RO, 'h444D4143 }}};
  `define SET_DMAC_IDENTIFICATION_IDENTIFICATION(x) SetField(DMAC_IDENTIFICATION,"IDENTIFICATION",x)
  `define GET_DMAC_IDENTIFICATION_IDENTIFICATION(x) GetField(DMAC_IDENTIFICATION,"IDENTIFICATION",x)

  const reg_t DMAC_INTERFACE_DESCRIPTION = '{ 'h0010, "INTERFACE_DESCRIPTION" , '{
    "BYTES_PER_BEAT_DEST_LOG2": '{ 3, 0, R, 0 },
    "DMA_TYPE_DEST": '{ 5, 4, R, 0 },
    "BYTES_PER_BEAT_SRC_LOG2": '{ 11, 8, R, 0 },
    "DMA_TYPE_SRC": '{ 13, 12, R, 0 },
    "BYTES_PER_BURST_WIDTH": '{ 19, 16, R, 0 }}};
  `define SET_DMAC_INTERFACE_DESCRIPTION_BYTES_PER_BEAT_DEST_LOG2(x) SetField(DMAC_INTERFACE_DESCRIPTION,"BYTES_PER_BEAT_DEST_LOG2",x)
  `define GET_DMAC_INTERFACE_DESCRIPTION_BYTES_PER_BEAT_DEST_LOG2(x) GetField(DMAC_INTERFACE_DESCRIPTION,"BYTES_PER_BEAT_DEST_LOG2",x)
  `define SET_DMAC_INTERFACE_DESCRIPTION_DMA_TYPE_DEST(x) SetField(DMAC_INTERFACE_DESCRIPTION,"DMA_TYPE_DEST",x)
  `define GET_DMAC_INTERFACE_DESCRIPTION_DMA_TYPE_DEST(x) GetField(DMAC_INTERFACE_DESCRIPTION,"DMA_TYPE_DEST",x)
  `define SET_DMAC_INTERFACE_DESCRIPTION_BYTES_PER_BEAT_SRC_LOG2(x) SetField(DMAC_INTERFACE_DESCRIPTION,"BYTES_PER_BEAT_SRC_LOG2",x)
  `define GET_DMAC_INTERFACE_DESCRIPTION_BYTES_PER_BEAT_SRC_LOG2(x) GetField(DMAC_INTERFACE_DESCRIPTION,"BYTES_PER_BEAT_SRC_LOG2",x)
  `define SET_DMAC_INTERFACE_DESCRIPTION_DMA_TYPE_SRC(x) SetField(DMAC_INTERFACE_DESCRIPTION,"DMA_TYPE_SRC",x)
  `define GET_DMAC_INTERFACE_DESCRIPTION_DMA_TYPE_SRC(x) GetField(DMAC_INTERFACE_DESCRIPTION,"DMA_TYPE_SRC",x)
  `define SET_DMAC_INTERFACE_DESCRIPTION_BYTES_PER_BURST_WIDTH(x) SetField(DMAC_INTERFACE_DESCRIPTION,"BYTES_PER_BURST_WIDTH",x)
  `define GET_DMAC_INTERFACE_DESCRIPTION_BYTES_PER_BURST_WIDTH(x) GetField(DMAC_INTERFACE_DESCRIPTION,"BYTES_PER_BURST_WIDTH",x)

  const reg_t DMAC_IRQ_MASK = '{ 'h0080, "IRQ_MASK" , '{
    "TRANSFER_COMPLETED": '{ 1, 1, RW, 'h1 },
    "TRANSFER_QUEUED": '{ 0, 0, RW, 'h1 }}};
  `define SET_DMAC_IRQ_MASK_TRANSFER_COMPLETED(x) SetField(DMAC_IRQ_MASK,"TRANSFER_COMPLETED",x)
  `define GET_DMAC_IRQ_MASK_TRANSFER_COMPLETED(x) GetField(DMAC_IRQ_MASK,"TRANSFER_COMPLETED",x)
  `define SET_DMAC_IRQ_MASK_TRANSFER_QUEUED(x) SetField(DMAC_IRQ_MASK,"TRANSFER_QUEUED",x)
  `define GET_DMAC_IRQ_MASK_TRANSFER_QUEUED(x) GetField(DMAC_IRQ_MASK,"TRANSFER_QUEUED",x)

  const reg_t DMAC_IRQ_PENDING = '{ 'h0084, "IRQ_PENDING" , '{
    "TRANSFER_COMPLETED": '{ 1, 1, RW1C, 'h0 },
    "TRANSFER_QUEUED": '{ 0, 0, RW1C, 'h0 }}};
  `define SET_DMAC_IRQ_PENDING_TRANSFER_COMPLETED(x) SetField(DMAC_IRQ_PENDING,"TRANSFER_COMPLETED",x)
  `define GET_DMAC_IRQ_PENDING_TRANSFER_COMPLETED(x) GetField(DMAC_IRQ_PENDING,"TRANSFER_COMPLETED",x)
  `define SET_DMAC_IRQ_PENDING_TRANSFER_QUEUED(x) SetField(DMAC_IRQ_PENDING,"TRANSFER_QUEUED",x)
  `define GET_DMAC_IRQ_PENDING_TRANSFER_QUEUED(x) GetField(DMAC_IRQ_PENDING,"TRANSFER_QUEUED",x)

  const reg_t DMAC_IRQ_SOURCE = '{ 'h0088, "IRQ_SOURCE" , '{
    "TRANSFER_COMPLETED": '{ 1, 1, RO, 'h0 },
    "TRANSFER_QUEUED": '{ 0, 0, RO, 'h0 }}};
  `define SET_DMAC_IRQ_SOURCE_TRANSFER_COMPLETED(x) SetField(DMAC_IRQ_SOURCE,"TRANSFER_COMPLETED",x)
  `define GET_DMAC_IRQ_SOURCE_TRANSFER_COMPLETED(x) GetField(DMAC_IRQ_SOURCE,"TRANSFER_COMPLETED",x)
  `define SET_DMAC_IRQ_SOURCE_TRANSFER_QUEUED(x) SetField(DMAC_IRQ_SOURCE,"TRANSFER_QUEUED",x)
  `define GET_DMAC_IRQ_SOURCE_TRANSFER_QUEUED(x) GetField(DMAC_IRQ_SOURCE,"TRANSFER_QUEUED",x)

  const reg_t DMAC_CONTROL = '{ 'h0400, "CONTROL" , '{
    "HWDESC": '{ 2, 2, RW, 'h0 },
    "PAUSE": '{ 1, 1, RW, 'h0 },
    "ENABLE": '{ 0, 0, RW, 'h0 }}};
  `define SET_DMAC_CONTROL_HWDESC(x) SetField(DMAC_CONTROL,"HWDESC",x)
  `define GET_DMAC_CONTROL_HWDESC(x) GetField(DMAC_CONTROL,"HWDESC",x)
  `define SET_DMAC_CONTROL_PAUSE(x) SetField(DMAC_CONTROL,"PAUSE",x)
  `define GET_DMAC_CONTROL_PAUSE(x) GetField(DMAC_CONTROL,"PAUSE",x)
  `define SET_DMAC_CONTROL_ENABLE(x) SetField(DMAC_CONTROL,"ENABLE",x)
  `define GET_DMAC_CONTROL_ENABLE(x) GetField(DMAC_CONTROL,"ENABLE",x)

  const reg_t DMAC_TRANSFER_ID = '{ 'h0404, "TRANSFER_ID" , '{
    "TRANSFER_ID": '{ 1, 0, RO, 'h00 }}};
  `define SET_DMAC_TRANSFER_ID_TRANSFER_ID(x) SetField(DMAC_TRANSFER_ID,"TRANSFER_ID",x)
  `define GET_DMAC_TRANSFER_ID_TRANSFER_ID(x) GetField(DMAC_TRANSFER_ID,"TRANSFER_ID",x)

  const reg_t DMAC_TRANSFER_SUBMIT = '{ 'h0408, "TRANSFER_SUBMIT" , '{
    "TRANSFER_SUBMIT": '{ 0, 0, RW, 'h0 }}};
  `define SET_DMAC_TRANSFER_SUBMIT_TRANSFER_SUBMIT(x) SetField(DMAC_TRANSFER_SUBMIT,"TRANSFER_SUBMIT",x)
  `define GET_DMAC_TRANSFER_SUBMIT_TRANSFER_SUBMIT(x) GetField(DMAC_TRANSFER_SUBMIT,"TRANSFER_SUBMIT",x)

  const reg_t DMAC_FLAGS = '{ 'h040c, "FLAGS" , '{
    "CYCLIC": '{ 0, 0, RW, 0 },
    "TLAST": '{ 1, 1, RW, 'h1 },
    "PARTIAL_REPORTING_EN": '{ 2, 2, RW, 'h0 }}};
  `define SET_DMAC_FLAGS_CYCLIC(x) SetField(DMAC_FLAGS,"CYCLIC",x)
  `define GET_DMAC_FLAGS_CYCLIC(x) GetField(DMAC_FLAGS,"CYCLIC",x)
  `define SET_DMAC_FLAGS_TLAST(x) SetField(DMAC_FLAGS,"TLAST",x)
  `define GET_DMAC_FLAGS_TLAST(x) GetField(DMAC_FLAGS,"TLAST",x)
  `define SET_DMAC_FLAGS_PARTIAL_REPORTING_EN(x) SetField(DMAC_FLAGS,"PARTIAL_REPORTING_EN",x)
  `define GET_DMAC_FLAGS_PARTIAL_REPORTING_EN(x) GetField(DMAC_FLAGS,"PARTIAL_REPORTING_EN",x)

  const reg_t DMAC_DEST_ADDRESS = '{ 'h0410, "DEST_ADDRESS" , '{
    "DEST_ADDRESS": '{ 31, 0, RW, 'h00000000 }}};
  `define SET_DMAC_DEST_ADDRESS_DEST_ADDRESS(x) SetField(DMAC_DEST_ADDRESS,"DEST_ADDRESS",x)
  `define GET_DMAC_DEST_ADDRESS_DEST_ADDRESS(x) GetField(DMAC_DEST_ADDRESS,"DEST_ADDRESS",x)

  const reg_t DMAC_SRC_ADDRESS = '{ 'h0414, "SRC_ADDRESS" , '{
    "SRC_ADDRESS": '{ 31, 0, RW, 'h00000000 }}};
  `define SET_DMAC_SRC_ADDRESS_SRC_ADDRESS(x) SetField(DMAC_SRC_ADDRESS,"SRC_ADDRESS",x)
  `define GET_DMAC_SRC_ADDRESS_SRC_ADDRESS(x) GetField(DMAC_SRC_ADDRESS,"SRC_ADDRESS",x)

  const reg_t DMAC_X_LENGTH = '{ 'h0418, "X_LENGTH" , '{
    "X_LENGTH": '{ 23, 0, RW, 0 }}};
  `define SET_DMAC_X_LENGTH_X_LENGTH(x) SetField(DMAC_X_LENGTH,"X_LENGTH",x)
  `define GET_DMAC_X_LENGTH_X_LENGTH(x) GetField(DMAC_X_LENGTH,"X_LENGTH",x)

  const reg_t DMAC_Y_LENGTH = '{ 'h041c, "Y_LENGTH" , '{
    "Y_LENGTH": '{ 23, 0, RW, 'h000000 }}};
  `define SET_DMAC_Y_LENGTH_Y_LENGTH(x) SetField(DMAC_Y_LENGTH,"Y_LENGTH",x)
  `define GET_DMAC_Y_LENGTH_Y_LENGTH(x) GetField(DMAC_Y_LENGTH,"Y_LENGTH",x)

  const reg_t DMAC_DEST_STRIDE = '{ 'h0420, "DEST_STRIDE" , '{
    "DEST_STRIDE": '{ 23, 0, RW, 'h000000 }}};
  `define SET_DMAC_DEST_STRIDE_DEST_STRIDE(x) SetField(DMAC_DEST_STRIDE,"DEST_STRIDE",x)
  `define GET_DMAC_DEST_STRIDE_DEST_STRIDE(x) GetField(DMAC_DEST_STRIDE,"DEST_STRIDE",x)

  const reg_t DMAC_SRC_STRIDE = '{ 'h0424, "SRC_STRIDE" , '{
    "SRC_STRIDE": '{ 23, 0, RW, 'h000000 }}};
  `define SET_DMAC_SRC_STRIDE_SRC_STRIDE(x) SetField(DMAC_SRC_STRIDE,"SRC_STRIDE",x)
  `define GET_DMAC_SRC_STRIDE_SRC_STRIDE(x) GetField(DMAC_SRC_STRIDE,"SRC_STRIDE",x)

  const reg_t DMAC_TRANSFER_DONE = '{ 'h0428, "TRANSFER_DONE" , '{
    "TRANSFER_0_DONE": '{ 0, 0, RO, 'h0 },
    "TRANSFER_1_DONE": '{ 1, 1, RO, 'h0 },
    "TRANSFER_2_DONE": '{ 2, 2, RO, 'h0 },
    "TRANSFER_3_DONE": '{ 3, 3, RO, 'h0 },
    "PARTIAL_TRANSFER_DONE": '{ 31, 31, RO, 'h0 }}};
  `define SET_DMAC_TRANSFER_DONE_TRANSFER_0_DONE(x) SetField(DMAC_TRANSFER_DONE,"TRANSFER_0_DONE",x)
  `define GET_DMAC_TRANSFER_DONE_TRANSFER_0_DONE(x) GetField(DMAC_TRANSFER_DONE,"TRANSFER_0_DONE",x)
  `define SET_DMAC_TRANSFER_DONE_TRANSFER_1_DONE(x) SetField(DMAC_TRANSFER_DONE,"TRANSFER_1_DONE",x)
  `define GET_DMAC_TRANSFER_DONE_TRANSFER_1_DONE(x) GetField(DMAC_TRANSFER_DONE,"TRANSFER_1_DONE",x)
  `define SET_DMAC_TRANSFER_DONE_TRANSFER_2_DONE(x) SetField(DMAC_TRANSFER_DONE,"TRANSFER_2_DONE",x)
  `define GET_DMAC_TRANSFER_DONE_TRANSFER_2_DONE(x) GetField(DMAC_TRANSFER_DONE,"TRANSFER_2_DONE",x)
  `define SET_DMAC_TRANSFER_DONE_TRANSFER_3_DONE(x) SetField(DMAC_TRANSFER_DONE,"TRANSFER_3_DONE",x)
  `define GET_DMAC_TRANSFER_DONE_TRANSFER_3_DONE(x) GetField(DMAC_TRANSFER_DONE,"TRANSFER_3_DONE",x)
  `define SET_DMAC_TRANSFER_DONE_PARTIAL_TRANSFER_DONE(x) SetField(DMAC_TRANSFER_DONE,"PARTIAL_TRANSFER_DONE",x)
  `define GET_DMAC_TRANSFER_DONE_PARTIAL_TRANSFER_DONE(x) GetField(DMAC_TRANSFER_DONE,"PARTIAL_TRANSFER_DONE",x)

  const reg_t DMAC_ACTIVE_TRANSFER_ID = '{ 'h042c, "ACTIVE_TRANSFER_ID" , '{
    "ACTIVE_TRANSFER_ID": '{ 4, 0, RO, 'h00 }}};
  `define SET_DMAC_ACTIVE_TRANSFER_ID_ACTIVE_TRANSFER_ID(x) SetField(DMAC_ACTIVE_TRANSFER_ID,"ACTIVE_TRANSFER_ID",x)
  `define GET_DMAC_ACTIVE_TRANSFER_ID_ACTIVE_TRANSFER_ID(x) GetField(DMAC_ACTIVE_TRANSFER_ID,"ACTIVE_TRANSFER_ID",x)

  const reg_t DMAC_STATUS = '{ 'h0430, "STATUS" , '{
    "RESERVED": '{ 31, 0, RO, 'h00000000 }}};
  `define SET_DMAC_STATUS_RESERVED(x) SetField(DMAC_STATUS,"RESERVED",x)
  `define GET_DMAC_STATUS_RESERVED(x) GetField(DMAC_STATUS,"RESERVED",x)

  const reg_t DMAC_CURRENT_DEST_ADDRESS = '{ 'h0434, "CURRENT_DEST_ADDRESS" , '{
    "CURRENT_DEST_ADDRESS": '{ 31, 0, RO, 'h00000000 }}};
  `define SET_DMAC_CURRENT_DEST_ADDRESS_CURRENT_DEST_ADDRESS(x) SetField(DMAC_CURRENT_DEST_ADDRESS,"CURRENT_DEST_ADDRESS",x)
  `define GET_DMAC_CURRENT_DEST_ADDRESS_CURRENT_DEST_ADDRESS(x) GetField(DMAC_CURRENT_DEST_ADDRESS,"CURRENT_DEST_ADDRESS",x)

  const reg_t DMAC_CURRENT_SRC_ADDRESS = '{ 'h0438, "CURRENT_SRC_ADDRESS" , '{
    "CURRENT_SRC_ADDRESS": '{ 31, 0, RO, 'h00000000 }}};
  `define SET_DMAC_CURRENT_SRC_ADDRESS_CURRENT_SRC_ADDRESS(x) SetField(DMAC_CURRENT_SRC_ADDRESS,"CURRENT_SRC_ADDRESS",x)
  `define GET_DMAC_CURRENT_SRC_ADDRESS_CURRENT_SRC_ADDRESS(x) GetField(DMAC_CURRENT_SRC_ADDRESS,"CURRENT_SRC_ADDRESS",x)

  const reg_t DMAC_TRANSFER_PROGRESS = '{ 'h0448, "TRANSFER_PROGRESS" , '{
    "TRANSFER_PROGRESS": '{ 23, 0, RO, 'h000000 }}};
  `define SET_DMAC_TRANSFER_PROGRESS_TRANSFER_PROGRESS(x) SetField(DMAC_TRANSFER_PROGRESS,"TRANSFER_PROGRESS",x)
  `define GET_DMAC_TRANSFER_PROGRESS_TRANSFER_PROGRESS(x) GetField(DMAC_TRANSFER_PROGRESS,"TRANSFER_PROGRESS",x)

  const reg_t DMAC_PARTIAL_TRANSFER_LENGTH = '{ 'h044c, "PARTIAL_TRANSFER_LENGTH" , '{
    "PARTIAL_LENGTH": '{ 31, 0, RO, 'h00000000 }}};
  `define SET_DMAC_PARTIAL_TRANSFER_LENGTH_PARTIAL_LENGTH(x) SetField(DMAC_PARTIAL_TRANSFER_LENGTH,"PARTIAL_LENGTH",x)
  `define GET_DMAC_PARTIAL_TRANSFER_LENGTH_PARTIAL_LENGTH(x) GetField(DMAC_PARTIAL_TRANSFER_LENGTH,"PARTIAL_LENGTH",x)

  const reg_t DMAC_PARTIAL_TRANSFER_ID = '{ 'h0450, "PARTIAL_TRANSFER_ID" , '{
    "PARTIAL_TRANSFER_ID": '{ 1, 0, RO, 'h0 }}};
  `define SET_DMAC_PARTIAL_TRANSFER_ID_PARTIAL_TRANSFER_ID(x) SetField(DMAC_PARTIAL_TRANSFER_ID,"PARTIAL_TRANSFER_ID",x)
  `define GET_DMAC_PARTIAL_TRANSFER_ID_PARTIAL_TRANSFER_ID(x) GetField(DMAC_PARTIAL_TRANSFER_ID,"PARTIAL_TRANSFER_ID",x)

  const reg_t DMAC_DESCRIPTOR_ID = '{ 'h0454, "DESCRIPTOR_ID" , '{
    "DESCRIPTOR_ID": '{ 31, 0, RO, 'h00000000 }}};
  `define SET_DMAC_DESCRIPTOR_ID_DESCRIPTOR_ID(x) SetField(DMAC_DESCRIPTOR_ID,"DESCRIPTOR_ID",x)
  `define GET_DMAC_DESCRIPTOR_ID_DESCRIPTOR_ID(x) GetField(DMAC_DESCRIPTOR_ID,"DESCRIPTOR_ID",x)

  const reg_t DMAC_SG_ADDRESS = '{ 'h047c, "SG_ADDRESS" , '{
    "SG_ADDRESS": '{ 31, 0, RW, 'h00000000 }}};
  `define SET_DMAC_SG_ADDRESS_SG_ADDRESS(x) SetField(DMAC_SG_ADDRESS,"SG_ADDRESS",x)
  `define GET_DMAC_SG_ADDRESS_SG_ADDRESS(x) GetField(DMAC_SG_ADDRESS,"SG_ADDRESS",x)

  const reg_t DMAC_DEST_ADDRESS_HIGH = '{ 'h0490, "DEST_ADDRESS_HIGH" , '{
    "DEST_ADDRESS_HIGH": '{ 31, 0, RW, 'h00000000 }}};
  `define SET_DMAC_DEST_ADDRESS_HIGH_DEST_ADDRESS_HIGH(x) SetField(DMAC_DEST_ADDRESS_HIGH,"DEST_ADDRESS_HIGH",x)
  `define GET_DMAC_DEST_ADDRESS_HIGH_DEST_ADDRESS_HIGH(x) GetField(DMAC_DEST_ADDRESS_HIGH,"DEST_ADDRESS_HIGH",x)

  const reg_t DMAC_SRC_ADDRESS_HIGH = '{ 'h0494, "SRC_ADDRESS_HIGH" , '{
    "SRC_ADDRESS_HIGH": '{ 31, 0, RW, 'h00000000 }}};
  `define SET_DMAC_SRC_ADDRESS_HIGH_SRC_ADDRESS_HIGH(x) SetField(DMAC_SRC_ADDRESS_HIGH,"SRC_ADDRESS_HIGH",x)
  `define GET_DMAC_SRC_ADDRESS_HIGH_SRC_ADDRESS_HIGH(x) GetField(DMAC_SRC_ADDRESS_HIGH,"SRC_ADDRESS_HIGH",x)

  const reg_t DMAC_CURRENT_DEST_ADDRESS_HIGH = '{ 'h0498, "CURRENT_DEST_ADDRESS_HIGH" , '{
    "CURRENT_DEST_ADDRESS_HIGH": '{ 31, 0, RO, 'h00000000 }}};
  `define SET_DMAC_CURRENT_DEST_ADDRESS_HIGH_CURRENT_DEST_ADDRESS_HIGH(x) SetField(DMAC_CURRENT_DEST_ADDRESS_HIGH,"CURRENT_DEST_ADDRESS_HIGH",x)
  `define GET_DMAC_CURRENT_DEST_ADDRESS_HIGH_CURRENT_DEST_ADDRESS_HIGH(x) GetField(DMAC_CURRENT_DEST_ADDRESS_HIGH,"CURRENT_DEST_ADDRESS_HIGH",x)

  const reg_t DMAC_CURRENT_SRC_ADDRESS_HIGH = '{ 'h049c, "CURRENT_SRC_ADDRESS_HIGH" , '{
    "CURRENT_SRC_ADDRESS_HIGH": '{ 31, 0, RO, 'h00000000 }}};
  `define SET_DMAC_CURRENT_SRC_ADDRESS_HIGH_CURRENT_SRC_ADDRESS_HIGH(x) SetField(DMAC_CURRENT_SRC_ADDRESS_HIGH,"CURRENT_SRC_ADDRESS_HIGH",x)
  `define GET_DMAC_CURRENT_SRC_ADDRESS_HIGH_CURRENT_SRC_ADDRESS_HIGH(x) GetField(DMAC_CURRENT_SRC_ADDRESS_HIGH,"CURRENT_SRC_ADDRESS_HIGH",x)

  const reg_t DMAC_SG_ADDRESS_HIGH = '{ 'h04bc, "SG_ADDRESS_HIGH" , '{
    "SG_ADDRESS_HIGH": '{ 31, 0, RW, 'h00000000 }}};
  `define SET_DMAC_SG_ADDRESS_HIGH_SG_ADDRESS_HIGH(x) SetField(DMAC_SG_ADDRESS_HIGH,"SG_ADDRESS_HIGH",x)
  `define GET_DMAC_SG_ADDRESS_HIGH_SG_ADDRESS_HIGH(x) GetField(DMAC_SG_ADDRESS_HIGH,"SG_ADDRESS_HIGH",x)


endpackage
