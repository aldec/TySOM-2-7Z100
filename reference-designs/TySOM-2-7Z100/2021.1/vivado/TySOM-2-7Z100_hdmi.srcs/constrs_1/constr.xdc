####################################################################################################
#################################### TySOM-2-7Z100 constraints #####################################
####################################################################################################

# Project configuration
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]

# USB 2.0 reset
set_property -dict {PACKAGE_PIN F17 IOSTANDARD LVCMOS18} [get_ports {usb_reset}]; # USB_RESET

# USER LEDS
set_property -dict {PACKAGE_PIN L14 IOSTANDARD LVCMOS18} [get_ports LEDS_tri_o[0]]; # LEDS[0]
set_property -dict {PACKAGE_PIN J13 IOSTANDARD LVCMOS18} [get_ports LEDS_tri_o[1]]; # LEDS[1]
set_property -dict {PACKAGE_PIN H13 IOSTANDARD LVCMOS18} [get_ports LEDS_tri_o[2]]; # LEDS[2]
set_property -dict {PACKAGE_PIN L13 IOSTANDARD LVCMOS18} [get_ports LEDS_tri_o[3]]; # LEDS[3]

# USER SWITCHES
set_property -dict {PACKAGE_PIN K13 IOSTANDARD LVCMOS18} [get_ports SWITCHES_tri_i[0]]; # SWITCHES[0]
set_property -dict {PACKAGE_PIN J14 IOSTANDARD LVCMOS18} [get_ports SWITCHES_tri_i[1]]; # SWITCHES[1]
set_property -dict {PACKAGE_PIN H14 IOSTANDARD LVCMOS18} [get_ports SWITCHES_tri_i[2]]; # SWITCHES[2]
set_property -dict {PACKAGE_PIN K15 IOSTANDARD LVCMOS18} [get_ports SWITCHES_tri_i[3]]; # SWITCHES[3]
set_property -dict {PACKAGE_PIN J15 IOSTANDARD LVCMOS18} [get_ports SWITCHES_tri_i[4]]; # SWITCHES[4]
set_property -dict {PACKAGE_PIN J16 IOSTANDARD LVCMOS18} [get_ports SWITCHES_tri_i[5]]; # SWITCHES[5]
set_property -dict {PACKAGE_PIN H16 IOSTANDARD LVCMOS18} [get_ports SWITCHES_tri_i[6]]; # SWITCHES[6]
set_property -dict {PACKAGE_PIN G17 IOSTANDARD LVCMOS18} [get_ports SWITCHES_tri_i[7]]; # SWITCHES[7]

# HDMI SYNCS
set_property  -dict {PACKAGE_PIN  D13  IOSTANDARD LVCMOS18} [get_ports hdmi_out_clk]
set_property  -dict {PACKAGE_PIN  B17  IOSTANDARD LVCMOS18} [get_ports hdmi_vsync]
set_property  -dict {PACKAGE_PIN  E17  IOSTANDARD LVCMOS18} [get_ports hdmi_hsync]
set_property  -dict {PACKAGE_PIN  C17  IOSTANDARD LVCMOS18} [get_ports hdmi_data_e]

# HDMI PIXEL DATA
set_property  -dict {PACKAGE_PIN  A17  IOSTANDARD LVCMOS18} [get_ports hdmi_data[0]]
set_property  -dict {PACKAGE_PIN  G16  IOSTANDARD LVCMOS18} [get_ports hdmi_data[1]]
set_property  -dict {PACKAGE_PIN  B16  IOSTANDARD LVCMOS18} [get_ports hdmi_data[2]]
set_property  -dict {PACKAGE_PIN  D14  IOSTANDARD LVCMOS18} [get_ports hdmi_data[3]]
set_property  -dict {PACKAGE_PIN  A14  IOSTANDARD LVCMOS18} [get_ports hdmi_data[4]]
set_property  -dict {PACKAGE_PIN  C14  IOSTANDARD LVCMOS18} [get_ports hdmi_data[5]]
set_property  -dict {PACKAGE_PIN  A12  IOSTANDARD LVCMOS18} [get_ports hdmi_data[6]]
set_property  -dict {PACKAGE_PIN  B11  IOSTANDARD LVCMOS18} [get_ports hdmi_data[7]]
set_property  -dict {PACKAGE_PIN  C11  IOSTANDARD LVCMOS18} [get_ports hdmi_data[8]]
set_property  -dict {PACKAGE_PIN  E12  IOSTANDARD LVCMOS18} [get_ports hdmi_data[9]]
set_property  -dict {PACKAGE_PIN  A15  IOSTANDARD LVCMOS18} [get_ports hdmi_data[10]]
set_property  -dict {PACKAGE_PIN  B14  IOSTANDARD LVCMOS18} [get_ports hdmi_data[11]]
set_property  -dict {PACKAGE_PIN  A13  IOSTANDARD LVCMOS18} [get_ports hdmi_data[12]]
set_property  -dict {PACKAGE_PIN  C13  IOSTANDARD LVCMOS18} [get_ports hdmi_data[13]]
set_property  -dict {PACKAGE_PIN  B12  IOSTANDARD LVCMOS18} [get_ports hdmi_data[14]]
set_property  -dict {PACKAGE_PIN  C12  IOSTANDARD LVCMOS18} [get_ports hdmi_data[15]]

# HDMI I2C BUS
set_property  -dict {PACKAGE_PIN B15   IOSTANDARD LVCMOS18 PULLTYPE PULLUP} [get_ports IIC_HDMI_scl_io]
set_property  -dict {PACKAGE_PIN D16   IOSTANDARD LVCMOS18 PULLTYPE PULLUP} [get_ports IIC_HDMI_sda_io]

################
# Clock Groups #
################

set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks -of_objects [get_pins -hier -filter {name=~*/ps7/inst/FCLK_CLK0}]]                        
