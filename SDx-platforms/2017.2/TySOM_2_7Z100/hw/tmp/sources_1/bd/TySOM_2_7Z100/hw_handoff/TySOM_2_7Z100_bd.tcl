
################################################################
# This is a generated script based on design: TySOM_2_7Z100
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2017.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source TySOM_2_7Z100_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7z100ffg900-2
}


# CHANGE DESIGN NAME HERE
set design_name TySOM_2_7Z100

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_msg_id "BD_TCL-001" "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_msg_id "BD_TCL-002" "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_msg_id "BD_TCL-003" "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_msg_id "BD_TCL-004" "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_msg_id "BD_TCL-005" "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_msg_id "BD_TCL-114" "ERROR" $errMsg}
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set DDR [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 DDR ]
  set FIXED_IO [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_processing_system7:fixedio_rtl:1.0 FIXED_IO ]
  set GPIO_SWITCHES [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 GPIO_SWITCHES ]
  set IIC_HDMI [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 IIC_HDMI ]

  # Create ports
  set hdmi_clk [ create_bd_port -dir O hdmi_clk ]
  set hdmi_data [ create_bd_port -dir O -from 15 -to 0 hdmi_data ]
  set hdmi_de [ create_bd_port -dir O hdmi_de ]
  set hdmi_hsync [ create_bd_port -dir O hdmi_hsync ]
  set hdmi_vsync [ create_bd_port -dir O hdmi_vsync ]
  set usb_reset [ create_bd_port -dir O -from 0 -to 0 -type rst usb_reset ]

  # Create instance: GND, and set properties
  set GND [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 GND ]
  set_property -dict [ list \
CONFIG.CONST_VAL {0} \
 ] $GND

  # Create instance: adi_axi_clkgen_0, and set properties
  set adi_axi_clkgen_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:adi_axi_clkgen:1.0 adi_axi_clkgen_0 ]
  set_property -dict [ list \
CONFIG.PCORE_CLK0_DIV {6} \
CONFIG.PCORE_CLK1_DIV {6} \
CONFIG.PCORE_CLKIN_PERIOD {5} \
CONFIG.PCORE_VCO_DIV {11} \
CONFIG.PCORE_VCO_MUL {49} \
 ] $adi_axi_clkgen_0

  # Create instance: axi_gpio_des, and set properties
  set axi_gpio_des [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_des ]
  set_property -dict [ list \
CONFIG.C_ALL_OUTPUTS {1} \
CONFIG.C_DOUT_DEFAULT {0x0000000E} \
CONFIG.C_GPIO_WIDTH {4} \
 ] $axi_gpio_des

  # Create instance: axi_gpio_switches, and set properties
  set axi_gpio_switches [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_switches ]
  set_property -dict [ list \
CONFIG.C_ALL_INPUTS {1} \
CONFIG.C_GPIO_WIDTH {8} \
 ] $axi_gpio_switches

  # Create instance: axi_iic_hdmi, and set properties
  set axi_iic_hdmi [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.0 axi_iic_hdmi ]

  # Create instance: axi_interconnect_0, and set properties
  set axi_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_0 ]
  set_property -dict [ list \
CONFIG.NUM_MI {9} \
 ] $axi_interconnect_0

  # Create instance: axi_protocol_converter_0, and set properties
  set axi_protocol_converter_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_protocol_converter:2.1 axi_protocol_converter_0 ]

  # Create instance: axi_vdma_hdmi, and set properties
  set axi_vdma_hdmi [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vdma:6.3 axi_vdma_hdmi ]
  set_property -dict [ list \
CONFIG.c_include_s2mm {0} \
CONFIG.c_mm2s_linebuffer_depth {4096} \
CONFIG.c_num_fstores {1} \
CONFIG.c_s2mm_genlock_mode {0} \
 ] $axi_vdma_hdmi

  # Create instance: axis_subset_converter_0, and set properties
  set axis_subset_converter_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_subset_converter:1.1 axis_subset_converter_0 ]
  set_property -dict [ list \
CONFIG.M_HAS_TKEEP {1} \
CONFIG.M_HAS_TLAST {1} \
CONFIG.M_TDATA_NUM_BYTES {3} \
CONFIG.M_TUSER_WIDTH {1} \
CONFIG.S_HAS_TKEEP {1} \
CONFIG.S_HAS_TLAST {1} \
CONFIG.S_TDATA_NUM_BYTES {4} \
CONFIG.S_TUSER_WIDTH {1} \
CONFIG.TDATA_REMAP {tdata[23:16],tdata[7:0],tdata[15:8]} \
CONFIG.TKEEP_REMAP {tkeep[2:0]} \
CONFIG.TLAST_REMAP {tlast[0]} \
CONFIG.TUSER_REMAP {tuser[0:0]} \
 ] $axis_subset_converter_0

  # Create instance: proc_sys_reset_100MHz_0, and set properties
  set proc_sys_reset_100MHz_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_100MHz_0 ]

  # Create instance: proc_sys_reset_150MHz_1, and set properties
  set proc_sys_reset_150MHz_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_150MHz_1 ]

  # Create instance: proc_sys_reset_200MHz_2, and set properties
  set proc_sys_reset_200MHz_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_200MHz_2 ]

  # Create instance: proc_sys_reset_50MHz_3, and set properties
  set proc_sys_reset_50MHz_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_50MHz_3 ]

  # Create instance: ps7, and set properties
  set ps7 [ create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 ps7 ]
  set_property -dict [ list \
CONFIG.PCW_ACT_APU_PERIPHERAL_FREQMHZ {800.000000} \
CONFIG.PCW_ACT_DCI_PERIPHERAL_FREQMHZ {10.096154} \
CONFIG.PCW_ACT_ENET0_PERIPHERAL_FREQMHZ {125.000000} \
CONFIG.PCW_ACT_FPGA0_PERIPHERAL_FREQMHZ {100.000000} \
CONFIG.PCW_ACT_FPGA1_PERIPHERAL_FREQMHZ {150.000000} \
CONFIG.PCW_ACT_FPGA2_PERIPHERAL_FREQMHZ {200.000000} \
CONFIG.PCW_ACT_FPGA3_PERIPHERAL_FREQMHZ {50.000000} \
CONFIG.PCW_ACT_QSPI_PERIPHERAL_FREQMHZ {200.000000} \
CONFIG.PCW_ACT_SDIO_PERIPHERAL_FREQMHZ {100.000000} \
CONFIG.PCW_ACT_TTC0_CLK0_PERIPHERAL_FREQMHZ {133.333344} \
CONFIG.PCW_ACT_TTC0_CLK1_PERIPHERAL_FREQMHZ {133.333344} \
CONFIG.PCW_ACT_TTC0_CLK2_PERIPHERAL_FREQMHZ {133.333344} \
CONFIG.PCW_ACT_TTC1_CLK0_PERIPHERAL_FREQMHZ {133.333344} \
CONFIG.PCW_ACT_TTC1_CLK1_PERIPHERAL_FREQMHZ {133.333344} \
CONFIG.PCW_ACT_TTC1_CLK2_PERIPHERAL_FREQMHZ {133.333344} \
CONFIG.PCW_ACT_UART_PERIPHERAL_FREQMHZ {100.000000} \
CONFIG.PCW_ACT_WDT_PERIPHERAL_FREQMHZ {133.333344} \
CONFIG.PCW_APU_PERIPHERAL_FREQMHZ {800} \
CONFIG.PCW_ARMPLL_CTRL_FBDIV {32} \
CONFIG.PCW_CLK0_FREQ {100000000} \
CONFIG.PCW_CLK1_FREQ {150000000} \
CONFIG.PCW_CLK2_FREQ {200000000} \
CONFIG.PCW_CLK3_FREQ {50000000} \
CONFIG.PCW_CPU_CPU_PLL_FREQMHZ {1600.000} \
CONFIG.PCW_CRYSTAL_PERIPHERAL_FREQMHZ {50} \
CONFIG.PCW_DCI_PERIPHERAL_DIVISOR0 {52} \
CONFIG.PCW_DCI_PERIPHERAL_DIVISOR1 {2} \
CONFIG.PCW_DDRPLL_CTRL_FBDIV {21} \
CONFIG.PCW_DDR_DDR_PLL_FREQMHZ {1050.000} \
CONFIG.PCW_DDR_RAM_HIGHADDR {0x3FFFFFFF} \
CONFIG.PCW_ENET0_ENET0_IO {MIO 16 .. 27} \
CONFIG.PCW_ENET0_GRP_MDIO_ENABLE {1} \
CONFIG.PCW_ENET0_GRP_MDIO_IO {MIO 52 .. 53} \
CONFIG.PCW_ENET0_PERIPHERAL_DIVISOR0 {8} \
CONFIG.PCW_ENET0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_ENET0_RESET_ENABLE {1} \
CONFIG.PCW_ENET0_RESET_IO {MIO 51} \
CONFIG.PCW_ENET_RESET_ENABLE {1} \
CONFIG.PCW_ENET_RESET_SELECT {Share reset pin} \
CONFIG.PCW_EN_CLK1_PORT {1} \
CONFIG.PCW_EN_CLK2_PORT {1} \
CONFIG.PCW_EN_CLK3_PORT {1} \
CONFIG.PCW_EN_EMIO_CD_SDIO0 {1} \
CONFIG.PCW_EN_EMIO_I2C1 {1} \
CONFIG.PCW_EN_ENET0 {1} \
CONFIG.PCW_EN_GPIO {1} \
CONFIG.PCW_EN_I2C0 {1} \
CONFIG.PCW_EN_I2C1 {1} \
CONFIG.PCW_EN_QSPI {1} \
CONFIG.PCW_EN_SDIO0 {1} \
CONFIG.PCW_EN_UART0 {1} \
CONFIG.PCW_EN_USB0 {1} \
CONFIG.PCW_FCLK0_PERIPHERAL_DIVISOR0 {5} \
CONFIG.PCW_FCLK0_PERIPHERAL_DIVISOR1 {2} \
CONFIG.PCW_FCLK1_PERIPHERAL_CLKSRC {DDR PLL} \
CONFIG.PCW_FCLK1_PERIPHERAL_DIVISOR0 {7} \
CONFIG.PCW_FCLK2_PERIPHERAL_DIVISOR0 {5} \
CONFIG.PCW_FCLK3_PERIPHERAL_DIVISOR0 {5} \
CONFIG.PCW_FCLK_CLK0_BUF {TRUE} \
CONFIG.PCW_FCLK_CLK1_BUF {TRUE} \
CONFIG.PCW_FCLK_CLK2_BUF {TRUE} \
CONFIG.PCW_FCLK_CLK3_BUF {TRUE} \
CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {100} \
CONFIG.PCW_FPGA1_PERIPHERAL_FREQMHZ {150} \
CONFIG.PCW_FPGA2_PERIPHERAL_FREQMHZ {200} \
CONFIG.PCW_FPGA_FCLK1_ENABLE {1} \
CONFIG.PCW_FPGA_FCLK2_ENABLE {1} \
CONFIG.PCW_FPGA_FCLK3_ENABLE {1} \
CONFIG.PCW_FTM_CTI_IN0 {<Select>} \
CONFIG.PCW_FTM_CTI_IN1 {<Select>} \
CONFIG.PCW_FTM_CTI_IN2 {<Select>} \
CONFIG.PCW_FTM_CTI_IN3 {<Select>} \
CONFIG.PCW_FTM_CTI_OUT0 {<Select>} \
CONFIG.PCW_FTM_CTI_OUT1 {<Select>} \
CONFIG.PCW_FTM_CTI_OUT2 {<Select>} \
CONFIG.PCW_FTM_CTI_OUT3 {<Select>} \
CONFIG.PCW_GPIO_MIO_GPIO_ENABLE {1} \
CONFIG.PCW_GPIO_MIO_GPIO_IO {MIO} \
CONFIG.PCW_I2C0_I2C0_IO {MIO 14 .. 15} \
CONFIG.PCW_I2C0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_I2C1_GRP_INT_ENABLE {1} \
CONFIG.PCW_I2C1_GRP_INT_IO {EMIO} \
CONFIG.PCW_I2C1_I2C1_IO {EMIO} \
CONFIG.PCW_I2C1_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_I2C_PERIPHERAL_FREQMHZ {133.333328} \
CONFIG.PCW_I2C_RESET_ENABLE {0} \
CONFIG.PCW_IOPLL_CTRL_FBDIV {20} \
CONFIG.PCW_IO_IO_PLL_FREQMHZ {1000.000} \
CONFIG.PCW_IRQ_F2P_INTR {1} \
CONFIG.PCW_MIO_0_DIRECTION {inout} \
CONFIG.PCW_MIO_0_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_0_PULLUP {enabled} \
CONFIG.PCW_MIO_0_SLEW {slow} \
CONFIG.PCW_MIO_10_DIRECTION {in} \
CONFIG.PCW_MIO_10_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_10_PULLUP {enabled} \
CONFIG.PCW_MIO_10_SLEW {slow} \
CONFIG.PCW_MIO_11_DIRECTION {out} \
CONFIG.PCW_MIO_11_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_11_PULLUP {enabled} \
CONFIG.PCW_MIO_11_SLEW {slow} \
CONFIG.PCW_MIO_12_DIRECTION {inout} \
CONFIG.PCW_MIO_12_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_12_PULLUP {enabled} \
CONFIG.PCW_MIO_12_SLEW {slow} \
CONFIG.PCW_MIO_13_DIRECTION {inout} \
CONFIG.PCW_MIO_13_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_13_PULLUP {enabled} \
CONFIG.PCW_MIO_13_SLEW {slow} \
CONFIG.PCW_MIO_14_DIRECTION {inout} \
CONFIG.PCW_MIO_14_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_14_PULLUP {enabled} \
CONFIG.PCW_MIO_14_SLEW {slow} \
CONFIG.PCW_MIO_15_DIRECTION {inout} \
CONFIG.PCW_MIO_15_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_15_PULLUP {enabled} \
CONFIG.PCW_MIO_15_SLEW {slow} \
CONFIG.PCW_MIO_16_DIRECTION {out} \
CONFIG.PCW_MIO_16_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_16_PULLUP {enabled} \
CONFIG.PCW_MIO_16_SLEW {slow} \
CONFIG.PCW_MIO_17_DIRECTION {out} \
CONFIG.PCW_MIO_17_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_17_PULLUP {enabled} \
CONFIG.PCW_MIO_17_SLEW {slow} \
CONFIG.PCW_MIO_18_DIRECTION {out} \
CONFIG.PCW_MIO_18_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_18_PULLUP {enabled} \
CONFIG.PCW_MIO_18_SLEW {slow} \
CONFIG.PCW_MIO_19_DIRECTION {out} \
CONFIG.PCW_MIO_19_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_19_PULLUP {enabled} \
CONFIG.PCW_MIO_19_SLEW {slow} \
CONFIG.PCW_MIO_1_DIRECTION {out} \
CONFIG.PCW_MIO_1_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_1_PULLUP {enabled} \
CONFIG.PCW_MIO_1_SLEW {slow} \
CONFIG.PCW_MIO_20_DIRECTION {out} \
CONFIG.PCW_MIO_20_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_20_PULLUP {enabled} \
CONFIG.PCW_MIO_20_SLEW {slow} \
CONFIG.PCW_MIO_21_DIRECTION {out} \
CONFIG.PCW_MIO_21_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_21_PULLUP {enabled} \
CONFIG.PCW_MIO_21_SLEW {slow} \
CONFIG.PCW_MIO_22_DIRECTION {in} \
CONFIG.PCW_MIO_22_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_22_PULLUP {enabled} \
CONFIG.PCW_MIO_22_SLEW {slow} \
CONFIG.PCW_MIO_23_DIRECTION {in} \
CONFIG.PCW_MIO_23_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_23_PULLUP {enabled} \
CONFIG.PCW_MIO_23_SLEW {slow} \
CONFIG.PCW_MIO_24_DIRECTION {in} \
CONFIG.PCW_MIO_24_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_24_PULLUP {enabled} \
CONFIG.PCW_MIO_24_SLEW {slow} \
CONFIG.PCW_MIO_25_DIRECTION {in} \
CONFIG.PCW_MIO_25_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_25_PULLUP {enabled} \
CONFIG.PCW_MIO_25_SLEW {slow} \
CONFIG.PCW_MIO_26_DIRECTION {in} \
CONFIG.PCW_MIO_26_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_26_PULLUP {enabled} \
CONFIG.PCW_MIO_26_SLEW {slow} \
CONFIG.PCW_MIO_27_DIRECTION {in} \
CONFIG.PCW_MIO_27_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_27_PULLUP {enabled} \
CONFIG.PCW_MIO_27_SLEW {slow} \
CONFIG.PCW_MIO_28_DIRECTION {inout} \
CONFIG.PCW_MIO_28_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_28_PULLUP {enabled} \
CONFIG.PCW_MIO_28_SLEW {slow} \
CONFIG.PCW_MIO_29_DIRECTION {in} \
CONFIG.PCW_MIO_29_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_29_PULLUP {enabled} \
CONFIG.PCW_MIO_29_SLEW {slow} \
CONFIG.PCW_MIO_2_DIRECTION {inout} \
CONFIG.PCW_MIO_2_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_2_PULLUP {disabled} \
CONFIG.PCW_MIO_2_SLEW {slow} \
CONFIG.PCW_MIO_30_DIRECTION {out} \
CONFIG.PCW_MIO_30_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_30_PULLUP {enabled} \
CONFIG.PCW_MIO_30_SLEW {slow} \
CONFIG.PCW_MIO_31_DIRECTION {in} \
CONFIG.PCW_MIO_31_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_31_PULLUP {enabled} \
CONFIG.PCW_MIO_31_SLEW {slow} \
CONFIG.PCW_MIO_32_DIRECTION {inout} \
CONFIG.PCW_MIO_32_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_32_PULLUP {enabled} \
CONFIG.PCW_MIO_32_SLEW {slow} \
CONFIG.PCW_MIO_33_DIRECTION {inout} \
CONFIG.PCW_MIO_33_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_33_PULLUP {enabled} \
CONFIG.PCW_MIO_33_SLEW {slow} \
CONFIG.PCW_MIO_34_DIRECTION {inout} \
CONFIG.PCW_MIO_34_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_34_PULLUP {enabled} \
CONFIG.PCW_MIO_34_SLEW {slow} \
CONFIG.PCW_MIO_35_DIRECTION {inout} \
CONFIG.PCW_MIO_35_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_35_PULLUP {enabled} \
CONFIG.PCW_MIO_35_SLEW {slow} \
CONFIG.PCW_MIO_36_DIRECTION {in} \
CONFIG.PCW_MIO_36_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_36_PULLUP {enabled} \
CONFIG.PCW_MIO_36_SLEW {slow} \
CONFIG.PCW_MIO_37_DIRECTION {inout} \
CONFIG.PCW_MIO_37_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_37_PULLUP {enabled} \
CONFIG.PCW_MIO_37_SLEW {slow} \
CONFIG.PCW_MIO_38_DIRECTION {inout} \
CONFIG.PCW_MIO_38_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_38_PULLUP {enabled} \
CONFIG.PCW_MIO_38_SLEW {slow} \
CONFIG.PCW_MIO_39_DIRECTION {inout} \
CONFIG.PCW_MIO_39_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_39_PULLUP {enabled} \
CONFIG.PCW_MIO_39_SLEW {slow} \
CONFIG.PCW_MIO_3_DIRECTION {inout} \
CONFIG.PCW_MIO_3_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_3_PULLUP {disabled} \
CONFIG.PCW_MIO_3_SLEW {slow} \
CONFIG.PCW_MIO_40_DIRECTION {inout} \
CONFIG.PCW_MIO_40_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_40_PULLUP {enabled} \
CONFIG.PCW_MIO_40_SLEW {slow} \
CONFIG.PCW_MIO_41_DIRECTION {inout} \
CONFIG.PCW_MIO_41_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_41_PULLUP {enabled} \
CONFIG.PCW_MIO_41_SLEW {slow} \
CONFIG.PCW_MIO_42_DIRECTION {inout} \
CONFIG.PCW_MIO_42_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_42_PULLUP {enabled} \
CONFIG.PCW_MIO_42_SLEW {slow} \
CONFIG.PCW_MIO_43_DIRECTION {inout} \
CONFIG.PCW_MIO_43_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_43_PULLUP {enabled} \
CONFIG.PCW_MIO_43_SLEW {slow} \
CONFIG.PCW_MIO_44_DIRECTION {inout} \
CONFIG.PCW_MIO_44_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_44_PULLUP {enabled} \
CONFIG.PCW_MIO_44_SLEW {slow} \
CONFIG.PCW_MIO_45_DIRECTION {inout} \
CONFIG.PCW_MIO_45_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_45_PULLUP {enabled} \
CONFIG.PCW_MIO_45_SLEW {slow} \
CONFIG.PCW_MIO_46_DIRECTION {inout} \
CONFIG.PCW_MIO_46_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_46_PULLUP {enabled} \
CONFIG.PCW_MIO_46_SLEW {slow} \
CONFIG.PCW_MIO_47_DIRECTION {inout} \
CONFIG.PCW_MIO_47_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_47_PULLUP {enabled} \
CONFIG.PCW_MIO_47_SLEW {slow} \
CONFIG.PCW_MIO_48_DIRECTION {inout} \
CONFIG.PCW_MIO_48_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_48_PULLUP {enabled} \
CONFIG.PCW_MIO_48_SLEW {slow} \
CONFIG.PCW_MIO_49_DIRECTION {inout} \
CONFIG.PCW_MIO_49_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_49_PULLUP {enabled} \
CONFIG.PCW_MIO_49_SLEW {slow} \
CONFIG.PCW_MIO_4_DIRECTION {inout} \
CONFIG.PCW_MIO_4_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_4_PULLUP {disabled} \
CONFIG.PCW_MIO_4_SLEW {slow} \
CONFIG.PCW_MIO_50_DIRECTION {inout} \
CONFIG.PCW_MIO_50_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_50_PULLUP {enabled} \
CONFIG.PCW_MIO_50_SLEW {slow} \
CONFIG.PCW_MIO_51_DIRECTION {out} \
CONFIG.PCW_MIO_51_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_51_PULLUP {enabled} \
CONFIG.PCW_MIO_51_SLEW {slow} \
CONFIG.PCW_MIO_52_DIRECTION {out} \
CONFIG.PCW_MIO_52_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_52_PULLUP {enabled} \
CONFIG.PCW_MIO_52_SLEW {slow} \
CONFIG.PCW_MIO_53_DIRECTION {inout} \
CONFIG.PCW_MIO_53_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_53_PULLUP {enabled} \
CONFIG.PCW_MIO_53_SLEW {slow} \
CONFIG.PCW_MIO_5_DIRECTION {inout} \
CONFIG.PCW_MIO_5_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_5_PULLUP {disabled} \
CONFIG.PCW_MIO_5_SLEW {slow} \
CONFIG.PCW_MIO_6_DIRECTION {out} \
CONFIG.PCW_MIO_6_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_6_PULLUP {disabled} \
CONFIG.PCW_MIO_6_SLEW {slow} \
CONFIG.PCW_MIO_7_DIRECTION {out} \
CONFIG.PCW_MIO_7_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_7_PULLUP {disabled} \
CONFIG.PCW_MIO_7_SLEW {slow} \
CONFIG.PCW_MIO_8_DIRECTION {out} \
CONFIG.PCW_MIO_8_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_8_PULLUP {disabled} \
CONFIG.PCW_MIO_8_SLEW {slow} \
CONFIG.PCW_MIO_9_DIRECTION {out} \
CONFIG.PCW_MIO_9_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_9_PULLUP {enabled} \
CONFIG.PCW_MIO_9_SLEW {slow} \
CONFIG.PCW_MIO_TREE_PERIPHERALS {GPIO#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#GPIO#GPIO#USB Reset#UART 0#UART 0#GPIO#GPIO#I2C 0#I2C 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#SD 0#SD 0#SD 0#SD 0#SD 0#SD 0#GPIO#GPIO#GPIO#GPIO#GPIO#ENET Reset#Enet 0#Enet 0} \
CONFIG.PCW_MIO_TREE_SIGNALS {gpio[0]#qspi0_ss_b#qspi0_io[0]#qspi0_io[1]#qspi0_io[2]#qspi0_io[3]#qspi0_sclk#gpio[7]#gpio[8]#reset#rx#tx#gpio[12]#gpio[13]#scl#sda#tx_clk#txd[0]#txd[1]#txd[2]#txd[3]#tx_ctl#rx_clk#rxd[0]#rxd[1]#rxd[2]#rxd[3]#rx_ctl#data[4]#dir#stp#nxt#data[0]#data[1]#data[2]#data[3]#clk#data[5]#data[6]#data[7]#clk#cmd#data[0]#data[1]#data[2]#data[3]#gpio[46]#gpio[47]#gpio[48]#gpio[49]#gpio[50]#reset#mdc#mdio} \
CONFIG.PCW_PACKAGE_DDR_BOARD_DELAY0 {0.100} \
CONFIG.PCW_PACKAGE_DDR_BOARD_DELAY1 {0.113} \
CONFIG.PCW_PACKAGE_DDR_BOARD_DELAY2 {0.111} \
CONFIG.PCW_PACKAGE_DDR_BOARD_DELAY3 {0.100} \
CONFIG.PCW_PACKAGE_DDR_DQS_TO_CLK_DELAY_0 {-0.017} \
CONFIG.PCW_PACKAGE_DDR_DQS_TO_CLK_DELAY_1 {-0.039} \
CONFIG.PCW_PACKAGE_DDR_DQS_TO_CLK_DELAY_2 {-0.040} \
CONFIG.PCW_PACKAGE_DDR_DQS_TO_CLK_DELAY_3 {-0.016} \
CONFIG.PCW_PCAP_PERIPHERAL_DIVISOR0 {5} \
CONFIG.PCW_PRESET_BANK0_VOLTAGE {LVCMOS 1.8V} \
CONFIG.PCW_PRESET_BANK1_VOLTAGE {LVCMOS 1.8V} \
CONFIG.PCW_QSPI_GRP_SINGLE_SS_ENABLE {1} \
CONFIG.PCW_QSPI_GRP_SINGLE_SS_IO {MIO 1 .. 6} \
CONFIG.PCW_QSPI_PERIPHERAL_DIVISOR0 {5} \
CONFIG.PCW_QSPI_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_QSPI_QSPI_IO {MIO 1 .. 6} \
CONFIG.PCW_SD0_GRP_CD_ENABLE {1} \
CONFIG.PCW_SD0_GRP_CD_IO {EMIO} \
CONFIG.PCW_SD0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_SD0_SD0_IO {MIO 40 .. 45} \
CONFIG.PCW_SDIO_PERIPHERAL_DIVISOR0 {10} \
CONFIG.PCW_SDIO_PERIPHERAL_VALID {1} \
CONFIG.PCW_UART0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_UART0_UART0_IO {MIO 10 .. 11} \
CONFIG.PCW_UART1_BAUD_RATE {9600} \
CONFIG.PCW_UART1_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_UART1_UART1_IO {<Select>} \
CONFIG.PCW_UART_PERIPHERAL_DIVISOR0 {10} \
CONFIG.PCW_UART_PERIPHERAL_VALID {1} \
CONFIG.PCW_UIPARAM_ACT_DDR_FREQ_MHZ {525.000000} \
CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY0 {0.317} \
CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY1 {0.164} \
CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY2 {0.169} \
CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY3 {0.195} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_0_PACKAGE_LENGTH {92.3275} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_1_PACKAGE_LENGTH {92.3275} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_2_PACKAGE_LENGTH {92.3275} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_3_PACKAGE_LENGTH {92.3275} \
CONFIG.PCW_UIPARAM_DDR_DEVICE_CAPACITY {2048 MBits} \
CONFIG.PCW_UIPARAM_DDR_DQS_0_PACKAGE_LENGTH {108.9255} \
CONFIG.PCW_UIPARAM_DDR_DQS_1_PACKAGE_LENGTH {131.286} \
CONFIG.PCW_UIPARAM_DDR_DQS_2_PACKAGE_LENGTH {131.83} \
CONFIG.PCW_UIPARAM_DDR_DQS_3_PACKAGE_LENGTH {108.5285} \
CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_0 {0.263} \
CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_1 {0.321} \
CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_2 {0.222} \
CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_3 {0.102} \
CONFIG.PCW_UIPARAM_DDR_DQ_0_PACKAGE_LENGTH {107.643} \
CONFIG.PCW_UIPARAM_DDR_DQ_1_PACKAGE_LENGTH {132.917} \
CONFIG.PCW_UIPARAM_DDR_DQ_2_PACKAGE_LENGTH {129.6135} \
CONFIG.PCW_UIPARAM_DDR_DQ_3_PACKAGE_LENGTH {108.6395} \
CONFIG.PCW_UIPARAM_DDR_FREQ_MHZ {525} \
CONFIG.PCW_UIPARAM_DDR_PARTNO {MT41K256M8 DA-125} \
CONFIG.PCW_UIPARAM_DDR_ROW_ADDR_COUNT {15} \
CONFIG.PCW_USB0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_USB0_RESET_ENABLE {1} \
CONFIG.PCW_USB0_RESET_IO {MIO 9} \
CONFIG.PCW_USB0_USB0_IO {MIO 28 .. 39} \
CONFIG.PCW_USB_RESET_ENABLE {1} \
CONFIG.PCW_USB_RESET_SELECT {Share reset pin} \
CONFIG.PCW_USE_FABRIC_INTERRUPT {1} \
CONFIG.PCW_USE_S_AXI_HP0 {1} \
CONFIG.PCW_USE_S_AXI_HP1 {1} \
 ] $ps7

  # Create instance: v_axi4s_vid_out_0, and set properties
  set v_axi4s_vid_out_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_axi4s_vid_out:4.0 v_axi4s_vid_out_0 ]
  set_property -dict [ list \
CONFIG.C_HAS_ASYNC_CLK {1} \
CONFIG.C_S_AXIS_VIDEO_FORMAT {0} \
CONFIG.C_VTG_MASTER_SLAVE {1} \
 ] $v_axi4s_vid_out_0

  # Create instance: v_cresample_0, and set properties
  set v_cresample_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_cresample:4.0 v_cresample_0 ]
  set_property -dict [ list \
CONFIG.has_axi4_lite {true} \
CONFIG.m_axis_video_format {2} \
CONFIG.num_h_taps {3} \
CONFIG.num_v_taps {0} \
CONFIG.s_axis_video_format {3} \
 ] $v_cresample_0

  # Create instance: v_osd_0, and set properties
  set v_osd_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_osd:6.0 v_osd_0 ]
  set_property -dict [ list \
CONFIG.LAYER0_HEIGHT {720} \
CONFIG.LAYER0_HORIZONTAL_START_POSITION {0} \
CONFIG.LAYER0_WIDTH {1280} \
CONFIG.LAYER1_HEIGHT {720} \
CONFIG.LAYER1_HORIZONTAL_START_POSITION {0} \
CONFIG.LAYER1_WIDTH {1280} \
CONFIG.LAYER2_HEIGHT {720} \
CONFIG.LAYER2_HORIZONTAL_START_POSITION {0} \
CONFIG.LAYER2_WIDTH {1280} \
CONFIG.LAYER3_HEIGHT {720} \
CONFIG.LAYER3_HORIZONTAL_START_POSITION {0} \
CONFIG.LAYER3_WIDTH {1280} \
CONFIG.LAYER4_HEIGHT {720} \
CONFIG.LAYER4_HORIZONTAL_START_POSITION {0} \
CONFIG.LAYER4_WIDTH {1280} \
CONFIG.LAYER5_HEIGHT {720} \
CONFIG.LAYER5_HORIZONTAL_START_POSITION {0} \
CONFIG.LAYER5_WIDTH {1280} \
CONFIG.LAYER6_HEIGHT {720} \
CONFIG.LAYER6_HORIZONTAL_START_POSITION {0} \
CONFIG.LAYER6_WIDTH {1280} \
CONFIG.LAYER7_HEIGHT {720} \
CONFIG.LAYER7_HORIZONTAL_START_POSITION {0} \
CONFIG.LAYER7_WIDTH {1280} \
CONFIG.M_AXIS_VIDEO_HEIGHT {1080} \
CONFIG.M_AXIS_VIDEO_WIDTH {1920} \
CONFIG.SCREEN_WIDTH {1920} \
 ] $v_osd_0

  # Create instance: v_rgb2ycrcb_0, and set properties
  set v_rgb2ycrcb_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_rgb2ycrcb:7.1 v_rgb2ycrcb_0 ]
  set_property -dict [ list \
CONFIG.HAS_AXI4_LITE {true} \
CONFIG.Output_Range {0_to_255_for_Computer_Graphics} \
CONFIG.Standard_Sel {YUV} \
CONFIG.cbmax {255} \
CONFIG.cbmin {0} \
CONFIG.ccoef {0.877283} \
CONFIG.crmax {255} \
CONFIG.crmin {0} \
CONFIG.dcoef {0.492111} \
CONFIG.ymax {255} \
CONFIG.ymin {0} \
 ] $v_rgb2ycrcb_0

  # Create instance: v_tc_0, and set properties
  set v_tc_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_tc:6.1 v_tc_0 ]
  set_property -dict [ list \
CONFIG.GEN_F0_VBLANK_HEND {1920} \
CONFIG.GEN_F0_VBLANK_HSTART {1920} \
CONFIG.GEN_F0_VFRAME_SIZE {1125} \
CONFIG.GEN_F0_VSYNC_HEND {1920} \
CONFIG.GEN_F0_VSYNC_HSTART {1920} \
CONFIG.GEN_F0_VSYNC_VEND {1088} \
CONFIG.GEN_F0_VSYNC_VSTART {1083} \
CONFIG.GEN_F1_VBLANK_HEND {1920} \
CONFIG.GEN_F1_VBLANK_HSTART {1920} \
CONFIG.GEN_F1_VFRAME_SIZE {1125} \
CONFIG.GEN_F1_VSYNC_HEND {1920} \
CONFIG.GEN_F1_VSYNC_HSTART {1920} \
CONFIG.GEN_F1_VSYNC_VEND {1088} \
CONFIG.GEN_F1_VSYNC_VSTART {1083} \
CONFIG.GEN_HACTIVE_SIZE {1920} \
CONFIG.GEN_HFRAME_SIZE {2200} \
CONFIG.GEN_HSYNC_END {2052} \
CONFIG.GEN_HSYNC_START {2008} \
CONFIG.GEN_VACTIVE_SIZE {1080} \
CONFIG.VIDEO_MODE {1080p} \
CONFIG.enable_detection {false} \
 ] $v_tc_0

  # Create instance: xlconcat, and set properties
  set xlconcat [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat ]
  set_property -dict [ list \
CONFIG.NUM_PORTS {3} \
 ] $xlconcat

  # Create interface connections
  connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_pins axi_interconnect_0/S00_AXI] [get_bd_intf_pins ps7/M_AXI_GP0]
  connect_bd_intf_net -intf_net axi_gpio_switches_GPIO [get_bd_intf_ports GPIO_SWITCHES] [get_bd_intf_pins axi_gpio_switches/GPIO]
  connect_bd_intf_net -intf_net axi_iic_hdmi_IIC [get_bd_intf_ports IIC_HDMI] [get_bd_intf_pins axi_iic_hdmi/IIC]
  connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI [get_bd_intf_pins axi_iic_hdmi/S_AXI] [get_bd_intf_pins axi_interconnect_0/M00_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M01_AXI [get_bd_intf_pins adi_axi_clkgen_0/s_axi] [get_bd_intf_pins axi_interconnect_0/M01_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M02_AXI [get_bd_intf_pins axi_interconnect_0/M02_AXI] [get_bd_intf_pins axi_vdma_hdmi/S_AXI_LITE]
  connect_bd_intf_net -intf_net axi_interconnect_0_M03_AXI [get_bd_intf_pins axi_interconnect_0/M03_AXI] [get_bd_intf_pins v_rgb2ycrcb_0/ctrl]
  connect_bd_intf_net -intf_net axi_interconnect_0_M04_AXI [get_bd_intf_pins axi_interconnect_0/M04_AXI] [get_bd_intf_pins v_cresample_0/ctrl]
  connect_bd_intf_net -intf_net axi_interconnect_0_M05_AXI [get_bd_intf_pins axi_interconnect_0/M05_AXI] [get_bd_intf_pins v_osd_0/ctrl]
  connect_bd_intf_net -intf_net axi_interconnect_0_M06_AXI [get_bd_intf_pins axi_interconnect_0/M06_AXI] [get_bd_intf_pins v_tc_0/ctrl]
  connect_bd_intf_net -intf_net axi_interconnect_0_M07_AXI [get_bd_intf_pins axi_gpio_switches/S_AXI] [get_bd_intf_pins axi_interconnect_0/M07_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M08_AXI [get_bd_intf_pins axi_gpio_des/S_AXI] [get_bd_intf_pins axi_interconnect_0/M08_AXI]
  connect_bd_intf_net -intf_net axi_protocol_converter_0_M_AXI [get_bd_intf_pins axi_protocol_converter_0/M_AXI] [get_bd_intf_pins ps7/S_AXI_HP0]
  connect_bd_intf_net -intf_net axi_vdma_hdmi_M_AXIS_MM2S [get_bd_intf_pins axi_vdma_hdmi/M_AXIS_MM2S] [get_bd_intf_pins axis_subset_converter_0/S_AXIS]
  connect_bd_intf_net -intf_net axi_vdma_hdmi_M_AXI_MM2S [get_bd_intf_pins axi_protocol_converter_0/S_AXI] [get_bd_intf_pins axi_vdma_hdmi/M_AXI_MM2S]
  connect_bd_intf_net -intf_net axis_subset_converter_0_M_AXIS [get_bd_intf_pins axis_subset_converter_0/M_AXIS] [get_bd_intf_pins v_rgb2ycrcb_0/video_in]
  connect_bd_intf_net -intf_net ps7_DDR [get_bd_intf_ports DDR] [get_bd_intf_pins ps7/DDR]
  connect_bd_intf_net -intf_net ps7_FIXED_IO [get_bd_intf_ports FIXED_IO] [get_bd_intf_pins ps7/FIXED_IO]
  connect_bd_intf_net -intf_net v_cresample_0_video_out [get_bd_intf_pins v_cresample_0/video_out] [get_bd_intf_pins v_osd_0/video_s0_in]
  connect_bd_intf_net -intf_net v_osd_0_video_out [get_bd_intf_pins v_axi4s_vid_out_0/video_in] [get_bd_intf_pins v_osd_0/video_out]
  connect_bd_intf_net -intf_net v_rgb2ycrcb_0_video_out [get_bd_intf_pins v_cresample_0/video_in] [get_bd_intf_pins v_rgb2ycrcb_0/video_out]
  connect_bd_intf_net -intf_net v_tc_0_vtiming_out [get_bd_intf_pins v_axi4s_vid_out_0/vtiming_in] [get_bd_intf_pins v_tc_0/vtiming_out]

  # Create port connections
  connect_bd_net -net GND_dout [get_bd_pins GND/dout] [get_bd_pins ps7/SDIO0_CDN]
  connect_bd_net -net adi_axi_clkgen_0_clk_0 [get_bd_ports hdmi_clk] [get_bd_pins adi_axi_clkgen_0/clk_0] [get_bd_pins v_axi4s_vid_out_0/vid_io_out_clk] [get_bd_pins v_tc_0/clk]
  connect_bd_net -net axi_iic_hdmi_iic2intc_irpt [get_bd_pins axi_iic_hdmi/iic2intc_irpt] [get_bd_pins xlconcat/In0]
  connect_bd_net -net axi_vdma_hdmi_mm2s_introut [get_bd_pins axi_vdma_hdmi/mm2s_introut] [get_bd_pins xlconcat/In1]
  connect_bd_net -net proc_sys_reset_100MHz_0_peripheral_aresetn [get_bd_pins adi_axi_clkgen_0/s_axi_aresetn] [get_bd_pins axi_gpio_des/s_axi_aresetn] [get_bd_pins axi_gpio_switches/s_axi_aresetn] [get_bd_pins axi_iic_hdmi/s_axi_aresetn] [get_bd_pins axi_interconnect_0/ARESETN] [get_bd_pins axi_interconnect_0/M00_ARESETN] [get_bd_pins axi_interconnect_0/M01_ARESETN] [get_bd_pins axi_interconnect_0/M02_ARESETN] [get_bd_pins axi_interconnect_0/M03_ARESETN] [get_bd_pins axi_interconnect_0/M04_ARESETN] [get_bd_pins axi_interconnect_0/M05_ARESETN] [get_bd_pins axi_interconnect_0/M06_ARESETN] [get_bd_pins axi_interconnect_0/M07_ARESETN] [get_bd_pins axi_interconnect_0/M08_ARESETN] [get_bd_pins axi_interconnect_0/S00_ARESETN] [get_bd_pins axi_vdma_hdmi/axi_resetn] [get_bd_pins proc_sys_reset_100MHz_0/peripheral_aresetn] [get_bd_pins v_cresample_0/s_axi_aresetn] [get_bd_pins v_osd_0/s_axi_aresetn] [get_bd_pins v_rgb2ycrcb_0/s_axi_aresetn] [get_bd_pins v_tc_0/s_axi_aresetn]
  connect_bd_net -net proc_sys_reset_100MHz_0_peripheral_reset [get_bd_ports usb_reset] [get_bd_pins proc_sys_reset_100MHz_0/peripheral_reset]
  connect_bd_net -net proc_sys_reset_150MHz_1_peripheral_aresetn [get_bd_pins axi_protocol_converter_0/aresetn] [get_bd_pins axis_subset_converter_0/aresetn] [get_bd_pins proc_sys_reset_150MHz_1/peripheral_aresetn]
  connect_bd_net -net ps7_FCLK_CLK0 [get_bd_pins adi_axi_clkgen_0/drp_clk] [get_bd_pins adi_axi_clkgen_0/s_axi_aclk] [get_bd_pins axi_gpio_des/s_axi_aclk] [get_bd_pins axi_gpio_switches/s_axi_aclk] [get_bd_pins axi_iic_hdmi/s_axi_aclk] [get_bd_pins axi_interconnect_0/ACLK] [get_bd_pins axi_interconnect_0/M00_ACLK] [get_bd_pins axi_interconnect_0/M01_ACLK] [get_bd_pins axi_interconnect_0/M02_ACLK] [get_bd_pins axi_interconnect_0/M03_ACLK] [get_bd_pins axi_interconnect_0/M04_ACLK] [get_bd_pins axi_interconnect_0/M05_ACLK] [get_bd_pins axi_interconnect_0/M06_ACLK] [get_bd_pins axi_interconnect_0/M07_ACLK] [get_bd_pins axi_interconnect_0/M08_ACLK] [get_bd_pins axi_interconnect_0/S00_ACLK] [get_bd_pins axi_vdma_hdmi/s_axi_lite_aclk] [get_bd_pins proc_sys_reset_100MHz_0/slowest_sync_clk] [get_bd_pins ps7/FCLK_CLK0] [get_bd_pins ps7/M_AXI_GP0_ACLK] [get_bd_pins v_cresample_0/s_axi_aclk] [get_bd_pins v_osd_0/s_axi_aclk] [get_bd_pins v_rgb2ycrcb_0/s_axi_aclk] [get_bd_pins v_tc_0/s_axi_aclk]
  connect_bd_net -net ps7_FCLK_CLK1 [get_bd_pins axi_protocol_converter_0/aclk] [get_bd_pins axi_vdma_hdmi/m_axi_mm2s_aclk] [get_bd_pins axi_vdma_hdmi/m_axis_mm2s_aclk] [get_bd_pins axis_subset_converter_0/aclk] [get_bd_pins proc_sys_reset_150MHz_1/slowest_sync_clk] [get_bd_pins ps7/FCLK_CLK1] [get_bd_pins ps7/S_AXI_HP0_ACLK] [get_bd_pins ps7/S_AXI_HP1_ACLK] [get_bd_pins v_axi4s_vid_out_0/aclk] [get_bd_pins v_cresample_0/aclk] [get_bd_pins v_osd_0/aclk] [get_bd_pins v_rgb2ycrcb_0/aclk]
  connect_bd_net -net ps7_FCLK_CLK2 [get_bd_pins adi_axi_clkgen_0/clk] [get_bd_pins proc_sys_reset_200MHz_2/slowest_sync_clk] [get_bd_pins ps7/FCLK_CLK2]
  connect_bd_net -net ps7_FCLK_CLK3 [get_bd_pins proc_sys_reset_50MHz_3/slowest_sync_clk] [get_bd_pins ps7/FCLK_CLK3]
  connect_bd_net -net ps7_FCLK_RESET0_N [get_bd_pins proc_sys_reset_100MHz_0/ext_reset_in] [get_bd_pins proc_sys_reset_150MHz_1/ext_reset_in] [get_bd_pins proc_sys_reset_200MHz_2/ext_reset_in] [get_bd_pins proc_sys_reset_50MHz_3/ext_reset_in] [get_bd_pins ps7/FCLK_RESET0_N]
  connect_bd_net -net v_axi4s_vid_out_0_vid_active_video [get_bd_ports hdmi_de] [get_bd_pins v_axi4s_vid_out_0/vid_active_video]
  connect_bd_net -net v_axi4s_vid_out_0_vid_data [get_bd_ports hdmi_data] [get_bd_pins v_axi4s_vid_out_0/vid_data]
  connect_bd_net -net v_axi4s_vid_out_0_vid_hsync [get_bd_ports hdmi_hsync] [get_bd_pins v_axi4s_vid_out_0/vid_hsync]
  connect_bd_net -net v_axi4s_vid_out_0_vid_vsync [get_bd_ports hdmi_vsync] [get_bd_pins v_axi4s_vid_out_0/vid_vsync]
  connect_bd_net -net v_axi4s_vid_out_0_vtg_ce [get_bd_pins v_axi4s_vid_out_0/vtg_ce] [get_bd_pins v_tc_0/gen_clken]
  connect_bd_net -net v_tc_0_irq [get_bd_pins v_tc_0/irq] [get_bd_pins xlconcat/In2]
  connect_bd_net -net xlconcat_dout [get_bd_pins ps7/IRQ_F2P] [get_bd_pins xlconcat/dout]

  # Create address segments
  create_bd_addr_seg -range 0x40000000 -offset 0x00000000 [get_bd_addr_spaces axi_vdma_hdmi/Data_MM2S] [get_bd_addr_segs ps7/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_ps7_HP0_DDR_LOWOCM
  create_bd_addr_seg -range 0x00010000 -offset 0x60000000 [get_bd_addr_spaces ps7/Data] [get_bd_addr_segs adi_axi_clkgen_0/s_axi/reg0] SEG_adi_axi_clkgen_0_reg0
  create_bd_addr_seg -range 0x00010000 -offset 0x41230000 [get_bd_addr_spaces ps7/Data] [get_bd_addr_segs axi_gpio_des/S_AXI/Reg] SEG_axi_gpio_des_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x41210000 [get_bd_addr_spaces ps7/Data] [get_bd_addr_segs axi_gpio_switches/S_AXI/Reg] SEG_axi_gpio_switches_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x41600000 [get_bd_addr_spaces ps7/Data] [get_bd_addr_segs axi_iic_hdmi/S_AXI/Reg] SEG_axi_iic_hdmi_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x43000000 [get_bd_addr_spaces ps7/Data] [get_bd_addr_segs axi_vdma_hdmi/S_AXI_LITE/Reg] SEG_axi_vdma_hdmi_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x43C10000 [get_bd_addr_spaces ps7/Data] [get_bd_addr_segs v_cresample_0/ctrl/Reg] SEG_v_cresample_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x43C20000 [get_bd_addr_spaces ps7/Data] [get_bd_addr_segs v_osd_0/ctrl/Reg] SEG_v_osd_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x43C00000 [get_bd_addr_spaces ps7/Data] [get_bd_addr_segs v_rgb2ycrcb_0/ctrl/Reg] SEG_v_rgb2ycrcb_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x43C30000 [get_bd_addr_spaces ps7/Data] [get_bd_addr_segs v_tc_0/ctrl/Reg] SEG_v_tc_0_Reg


  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


