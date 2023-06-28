# Project configuration
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]

# USB 2.0 reset
set_property -dict {PACKAGE_PIN F17 IOSTANDARD LVCMOS18} [get_ports {USB_RESET}]; # USB_RESET

# FMC-VISION USB control lines
set_property -dict {PACKAGE_PIN V21 IOSTANDARD LVCMOS18 PULLTYPE PULLDOWN} [get_ports {GPIO_tri_io[0]}]; # USB_GRST
set_property -dict {PACKAGE_PIN R21 IOSTANDARD LVCMOS18} [get_ports {GPIO_tri_io[1]}]; # USB_WAKE#
# set_property -dict {PACKAGE_PIN U21 IOSTANDARD LVCMOS18} [get_ports {GPIO_tri_io[2]}]; # USB_PCIE_PERST#

# FMC-VISION PCIE x1
#set_property PACKAGE_PIN AA8 [get_ports PCIE_REFCLK]
set_property PACKAGE_PIN AA8 [get_ports PCIE_REFCLK_clk_p]; # 100 MHz
set_property PACKAGE_PIN AD6 [get_ports PCIE_rxp[0]]
set_property PACKAGE_PIN AD2 [get_ports PCIE_txp[0]]

create_clock -period 10 -name pcie_refclk [get_ports PCIE_REFCLK_clk_p]

set_property -dict {PACKAGE_PIN U21 IOSTANDARD LVCMOS18} [get_ports {PCIE_RST_n}]; # USB_PCIE_PERST#