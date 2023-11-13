![Aldec, Inc.](https://www.aldec.com/images/content/corporate/Corporate_Logo_Aldec_Crescent.png)
## TySOM-2-7Z100 example design with support for HDMI with using ADV7511. The design uses Video Test Pattern Generator IP as a video stream source.
|||
|---|---|
|Host|TySOM-2-7Z100|

### Software requirements
- Vitis 2023.1

### How to rebuild the application project

1. Source Xilinx Vitis 2023.1 tool
```bash
source <vitis_installation_path>/settings64.sh
```
2. Go to app directory and run *create_app.tcl* script
```bash
xsct create_app.tcl
```
The script creates an application project.

3. Run vitis and set a workspace path
```bash
vitis -workspace vtpg_example.sdk
```
4. Build the project
5. Output files are generated to one of below directories

- `<workspace_path>/<project_name>_system/Release/sd_card`
- `<workspace_path>/<project_name>_system/Debug/sd_card`

The path depends on the active build configuration setting.

6. Copy BOOT.BIN file to micro SD and run the example on TySOM-2-7Z100 evaluation board.