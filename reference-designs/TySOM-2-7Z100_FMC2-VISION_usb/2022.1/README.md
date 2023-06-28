![Aldec, Inc.](https://www.aldec.com/images/content/corporate/Corporate_Logo_Aldec_Crescent.png)
## USB 3.0 example design for TySOM-2-7Z100 development board with FMC-VISION
This is example design for Aldec TySOM-2-7Z100 development board with FMC-VISION daughter board. The design performs USB 3.0 functionality based on FMC-VISION hardware.

### Hardware requirements
- Host board: [TySOM-2-7Z100](https://www.aldec.com/en/products/emulation/tysom_boards/zynq_7000_soc/tysom_2_7z100#description)
- Host connector: FMC2
- FMC module: [FMC-VISION](https://www.aldec.com/en/products/emulation/daughter_cards/fmc_daughter/fmc_vision#description)

### Software requirements
- Vivado 2022.1
- Petalinux 2022.1

### Supported hardware
- 2x USB 3.0 on FMC-VISION
- 4x USB 2.0
- Ethernet
- micro SD
- UART

### Package structure
- Files:
	- README.md: this readme
	- sd_card: pre-built boot files to copy on micro SD card
	- vivado: directory with files for Vivado design regeneration and readme
	- petalinux: directory with Petalinux 2022.1 BSP and readme

### Quick start guide
1. Copy ***sd_card*** directory content to micro SD card
2. Insert memory card to TySOM-2-7Z100 evaluation board
3. Insert FMC-VISION to FMC2 connector of TySOM-2-7Z100
4. Connect UART cable
5. Connect power supply to TySOM board
6. Power on the board
7. Check if USB 3.0 devices are detected

### Known issues
- Sometimes kernel displays message
```bash
xilinx-pcie 50000000.axi-pcie: Link Down
```
In that case USB 3.0 can not work properly. The issue appears mainly in first booting after powering-on the board.

Solution: reboot the board
