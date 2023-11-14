![Aldec, Inc.](https://www.aldec.com/images/content/corporate/Corporate_Logo_Aldec_Crescent.png)
## HDMI example design with Video Test Pattern Generator controlled by standalone application
The design bases on a pipeline built with Xilinx ip cores: Video Test Pattern Generator, Video Timing Controler and AXI4-Stream to Video Out. Video stream is connected to ADV7511 hardware transmitter.

The hardware design is managed by baremetal drivers integrated to the standalone vtpg_example application. The application displays video stream on a monitor. It allows to adjust video resolution and pattern selection. It supports resolution up to 1920x1080.

For more information about video on Zynq 7000 devices refer to [Xilinx Video Series blog](https://support.xilinx.com/s/question/0D52E00006xR6koSAC/video-blog-series).

### Hardware requirements
- Host board: [TySOM-2-7Z100](https://www.aldec.com/en/products/emulation/tysom_boards/zynq_7000_soc/tysom_2_7z100#description)
<img src="https://www.aldec.com/images/content/products/tysom_boards/zynq_7000/tysom_2_view.jpg" alt="image" width="300" height="auto">

### Software requirements
- installed Xilinx Vivado 2023.1 tool
- installed Xilinx Vitis 2023.1 tool

### List of directories
- **TySOM-2-7Z100_vtpg/2023.1**
  - **README.md**: this readme
  - **app**: standalone application sources and readme
  - **platform**: Vitis platform
  - **sd_card**: pre-built boot files to copy on micro SD card
  - **vivado**: files for hardware design and Vitis platform regeneration with readme

Navigate to the directories in further steps.

### Quick start guide
Ready to test files are located in **sd_card** directory.

1. Copy ***sd_card*** directory content to micro SD card
2. Insert memory card to TySOM-2-7Z100 evaluation board
3. Connect HDMI cable to a monitor
4. Connect UART cable
5. Connect power supply to TySOM board
6. Power on the board
7. Check if a test pattern is displayed on the monitor

<img src="./images/colorbar.png" alt="image" width="auto" height="200">

8. The application can be controlled via UART.
```bash
################################################################################
###                         HDMI Example Application                         ###
###                             Aldec, Inc. 2023                             ###
################################################################################
TPG application on TySOM-2-7Z100 using on-board HDMI
HDMI Monitor connected
HDMI Setup Complete!
TPG started!
MENU: Select command:
0 - select resolution
1 - select pattern
```
Writing characters on UART allows to move through the menu. Commands must be accepted by 'Enter'. The command input is not protected for invalid input. Take care about typing proper values.

9. Type '1' and press ENTER. Select one option from the menu to change a test pattern.

```bash
MENU: Select pattern (range <1-20>):
1  - H_RAMP
2  - V_RAMP
3  - TEMPORAL_RAMP
4  - SOLID_RED
5  - SOLID_GREEN
6  - SOLID_BLUE
7  - SOLID_BLACK
8  - SOLID_WHITE
9  - COLOR_BARS
10 - ZONE_PLATE
11 - TARTAN_COLOR_BARS
12 - CROSS_HATCH
13 - RAINBOW_COLOR
14 - HV_RAMP
15 - CHECKER_BOARD
16 - PBRS
17 - DP_COLOR_RAMP
18 - DP_BW_VERTICAL_LINE
19 - DP_COLOR_SQUARE
20 - LAST
INFO: pattern = XTPG_BKGND_CROSS_HATCH
MENU: Select command:
0 - select resolution
1 - select pattern
```
The image on the screen should change to the crosshatch test pattern.

<img src="./images/crosshatch.jpg" alt="image" width="auto" height="200">

10. Type '0' and press ENTER. Select one option from the menu to change a video resolution.
```bash
MENU: Select resolution:
1 - 1920x1080
2 - 1280x720
3 - 800x600
4 - 640x480
INFO: resolution = 1920x1080
MENU: Select command:
0 - select resolution
1 - select pattern
```
Video stream should be updated to chosen resolution.

### Known issues
- none
