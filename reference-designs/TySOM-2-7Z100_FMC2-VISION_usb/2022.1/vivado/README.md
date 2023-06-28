![Aldec, Inc.](https://www.aldec.com/images/content/corporate/Corporate_Logo_Aldec_Crescent.png)
## TySOM-2-7Z100 example design with support for USB 3.0 on FMC-VISION daughter board.
|||
|---|---|
|Host|TySOM-2-7Z100|
|FMC connector|FMC2|
|FMC module|FMC-VISION|

### Software requirements
- Vivado 2022.1
- The design requires Vivado board definition (rev. 1.2) for TySOM-2-7Z100 development board.
Download it from:
[TySOM-2-7Z100 repository](https://github.com/aldec/TySOM-2-7Z100/tree/master/Vivado-board_files/2018.3/TySOM-2-7Z100)
and place it to vivado_board_definitions or add to default Vivado repository.

The project was built with using US locale settings.
```bash
LANG="en_US.UTF-8"
export LANG
```
### Build the project
Build the project with using a TCL script.
1. Go to "vivado" directory (directory with TCL script for the example design).
2. Source Vivado 2022.1 settings64.sh file
```bash
source <vivado_2022_1_path>/settings64.sh
```
3. Launch Vivado tool and run the script:
```bash
vivado -source ./TySOM-2-7Z100_FMC2-VISION_usb.tcl
```
4. Run "Generate Bitstream"
