//Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2017.2_sdx (lin64) Build 1972098 Wed Aug 23 11:34:38 MDT 2017
//Date        : Thu Oct 12 14:39:08 2017
//Host        : enki running 64-bit unknown
//Command     : generate_target TySOM_2_7Z100_wrapper.bd
//Design      : TySOM_2_7Z100_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module TySOM_2_7Z100_wrapper
   (DDR_addr,
    DDR_ba,
    DDR_cas_n,
    DDR_ck_n,
    DDR_ck_p,
    DDR_cke,
    DDR_cs_n,
    DDR_dm,
    DDR_dq,
    DDR_dqs_n,
    DDR_dqs_p,
    DDR_odt,
    DDR_ras_n,
    DDR_reset_n,
    DDR_we_n,
    FIXED_IO_ddr_vrn,
    FIXED_IO_ddr_vrp,
    FIXED_IO_mio,
    FIXED_IO_ps_clk,
    FIXED_IO_ps_porb,
    FIXED_IO_ps_srstb,
    gpio_switches_tri_i,
    hdmi_clk,
    hdmi_data,
    hdmi_de,
    hdmi_hsync,
    hdmi_vsync,
    iic_hdmi_scl_io,
    iic_hdmi_sda_io,
    usb_reset);
  inout [14:0]DDR_addr;
  inout [2:0]DDR_ba;
  inout DDR_cas_n;
  inout DDR_ck_n;
  inout DDR_ck_p;
  inout DDR_cke;
  inout DDR_cs_n;
  inout [3:0]DDR_dm;
  inout [31:0]DDR_dq;
  inout [3:0]DDR_dqs_n;
  inout [3:0]DDR_dqs_p;
  inout DDR_odt;
  inout DDR_ras_n;
  inout DDR_reset_n;
  inout DDR_we_n;
  inout FIXED_IO_ddr_vrn;
  inout FIXED_IO_ddr_vrp;
  inout [53:0]FIXED_IO_mio;
  inout FIXED_IO_ps_clk;
  inout FIXED_IO_ps_porb;
  inout FIXED_IO_ps_srstb;
  input [7:0]gpio_switches_tri_i;
  output hdmi_clk;
  output [15:0]hdmi_data;
  output hdmi_de;
  output hdmi_hsync;
  output hdmi_vsync;
  inout iic_hdmi_scl_io;
  inout iic_hdmi_sda_io;
  output [0:0]usb_reset;

  wire [14:0]DDR_addr;
  wire [2:0]DDR_ba;
  wire DDR_cas_n;
  wire DDR_ck_n;
  wire DDR_ck_p;
  wire DDR_cke;
  wire DDR_cs_n;
  wire [3:0]DDR_dm;
  wire [31:0]DDR_dq;
  wire [3:0]DDR_dqs_n;
  wire [3:0]DDR_dqs_p;
  wire DDR_odt;
  wire DDR_ras_n;
  wire DDR_reset_n;
  wire DDR_we_n;
  wire FIXED_IO_ddr_vrn;
  wire FIXED_IO_ddr_vrp;
  wire [53:0]FIXED_IO_mio;
  wire FIXED_IO_ps_clk;
  wire FIXED_IO_ps_porb;
  wire FIXED_IO_ps_srstb;
  wire [7:0]gpio_switches_tri_i;
  wire hdmi_clk;
  wire [15:0]hdmi_data;
  wire hdmi_de;
  wire hdmi_hsync;
  wire hdmi_vsync;
  wire iic_hdmi_scl_i;
  wire iic_hdmi_scl_io;
  wire iic_hdmi_scl_o;
  wire iic_hdmi_scl_t;
  wire iic_hdmi_sda_i;
  wire iic_hdmi_sda_io;
  wire iic_hdmi_sda_o;
  wire iic_hdmi_sda_t;
  wire [0:0]usb_reset;

  TySOM_2_7Z100 TySOM_2_7Z100_i
       (.DDR_addr(DDR_addr),
        .DDR_ba(DDR_ba),
        .DDR_cas_n(DDR_cas_n),
        .DDR_ck_n(DDR_ck_n),
        .DDR_ck_p(DDR_ck_p),
        .DDR_cke(DDR_cke),
        .DDR_cs_n(DDR_cs_n),
        .DDR_dm(DDR_dm),
        .DDR_dq(DDR_dq),
        .DDR_dqs_n(DDR_dqs_n),
        .DDR_dqs_p(DDR_dqs_p),
        .DDR_odt(DDR_odt),
        .DDR_ras_n(DDR_ras_n),
        .DDR_reset_n(DDR_reset_n),
        .DDR_we_n(DDR_we_n),
        .FIXED_IO_ddr_vrn(FIXED_IO_ddr_vrn),
        .FIXED_IO_ddr_vrp(FIXED_IO_ddr_vrp),
        .FIXED_IO_mio(FIXED_IO_mio),
        .FIXED_IO_ps_clk(FIXED_IO_ps_clk),
        .FIXED_IO_ps_porb(FIXED_IO_ps_porb),
        .FIXED_IO_ps_srstb(FIXED_IO_ps_srstb),
        .GPIO_SWITCHES_tri_i(gpio_switches_tri_i),
        .IIC_HDMI_scl_i(iic_hdmi_scl_i),
        .IIC_HDMI_scl_o(iic_hdmi_scl_o),
        .IIC_HDMI_scl_t(iic_hdmi_scl_t),
        .IIC_HDMI_sda_i(iic_hdmi_sda_i),
        .IIC_HDMI_sda_o(iic_hdmi_sda_o),
        .IIC_HDMI_sda_t(iic_hdmi_sda_t),
        .hdmi_clk(hdmi_clk),
        .hdmi_data(hdmi_data),
        .hdmi_de(hdmi_de),
        .hdmi_hsync(hdmi_hsync),
        .hdmi_vsync(hdmi_vsync),
        .usb_reset(usb_reset));
  IOBUF iic_hdmi_scl_iobuf
       (.I(iic_hdmi_scl_o),
        .IO(iic_hdmi_scl_io),
        .O(iic_hdmi_scl_i),
        .T(iic_hdmi_scl_t));
  IOBUF iic_hdmi_sda_iobuf
       (.I(iic_hdmi_sda_o),
        .IO(iic_hdmi_sda_io),
        .O(iic_hdmi_sda_i),
        .T(iic_hdmi_sda_t));
endmodule
