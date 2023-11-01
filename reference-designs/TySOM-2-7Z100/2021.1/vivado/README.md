![Aldec, Inc.](https://www.aldec.com/images/content/corporate/Corporate_Logo_Aldec_Crescent.png)
## TySOM-2-7Z100 example design with support for HDMI with using ADV7511.
|||
|---|---|
|Host|TySOM-2-7Z100|

### Software requirements
- Vivado 2021.1
- The design requires Vivado board definition (rev. 1.2) for TySOM-2-7Z100 development board.
Download it from:
[github.com](https://github.com/aldec/TySOM-2-7Z100/tree/master/Vivado-board_files/2018.3/TySOM-2-7Z100)
- the design requires axi_clkgen ip core from Analog Devices repository

The project was built with using US locale settings.
```bash
LANG="en_US.UTF-8"
export LANG
```
### Build the project
1. Go to "vivado" directory (directory with TCL script for the example design).
2. Run the script create_project.sh
```bash
./create_project.sh
```
3. Run "Generate Bitstream"
