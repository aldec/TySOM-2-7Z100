![Aldec, Inc.](https://www.aldec.com/images/content/corporate/Corporate_Logo_Aldec_Crescent.png)
## TySOM-2-7Z100 example design with support for HDMI with using ADV7511. The design uses Video Test Pattern Generator IP as a video stream source.
|||
|---|---|
|Host|TySOM-2-7Z100|

### Software requirements
- Vivado 2023.1
- The design requires Vivado board definition (rev. 1.2) for TySOM-2-7Z100 development board.
Download it from:
[github.com](https://github.com/aldec/TySOM-2-7Z100/tree/master/Vivado-board_files/2018.3/TySOM-2-7Z100)

The project was built with using US locale settings.
```bash
LANG="en_US.UTF-8"
export LANG
```
### How to regenerate the hardware design and Vitis platform

1. Source Xilinx Vivado 2023.1 tool
```bash
source <vivado_installation_path>/settings64.sh
```
2. Go to **vivado** directory
```bash
cd vivado
```
3. Rebuild the example Vivado design
```bash
vivado -source ./TySOM-2-7Z100_vtpg.tcl
```
4. Run "Generate Bitstream"
5. Export the hardware platform. Set XSA file name to system_wrapper. Export the file to default project directory (**vivado/TySOM-2-7Z100_vtpg**).
```
File -> Export... -> Export Hardware -> Include bitstream -> Set name -> Finish
```
6. Close Vivado
7. Source Xilinx Vitis 2023.1 tool
```bash
source <vitis_installation_path>/settings64.sh
```
8. Run the script to prepare Vitis platform
```bash
xsct generate_platform.tcl
```
9. The prepared Vitis platform should be in **vivado/TySOM-2-7Z100_vtpg/TySOM-2-7Z100_vtpg.sdk/TySOM-2-7Z100_vtpg/export** directory
10. Add platform to Vitis workspace. Launch Vitis and navigate to
```
Xilinx -> Platform Repositories... -> Add Custom Platform... -> Select platform directory -> Apply "OK"
```
11. The platform is ready to work with Vitis application projects.
