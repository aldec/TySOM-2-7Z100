![Aldec, Inc.](https://www.aldec.com/images/content/corporate/Corporate_Logo_Aldec_Crescent.png)
## HDMI example design for TySOM-2-7Z100 development board
This is example design for Aldec TySOM-2-7Z100 development board. The design performs HDMI functionality based on ADV7511 transmitter. The design supports up to 1080p resolution. The platform is powered by Petalinux operating system.

### Hardware requirements
- Host board: [TySOM-2-7Z100](https://www.aldec.com/en/products/emulation/tysom_boards/zynq_7000_soc/tysom_2_7z100#description)

### Software requirements
- Vivado 2021.1
- Petalinux 2021.1

### Supported hardware
- HDMI
- 4x USB 2.0
- Ethernet
- micro SD
- UART

### Package structure
- Files:
	- README.md: this readme
	- sd_card: pre-built boot files to copy on micro SD card
	- vivado: directory with files for Vivado design regeneration and readme
	- petalinux: directory with Petalinux 2021.1 BSP and readme

### Quick start guide
1. Copy ***sd_card*** directory content to micro SD card
2. Insert memory card to TySOM-2-7Z100 evaluation board
3. Connect HDMI cable to a monitor
4. Connect UART cable
5. Connect power supply to TySOM board
6. Power on the board
7. Check if system log is displayed on the monitor

### Known issues
- none