![Aldec, Inc.](https://www.aldec.com/images/content/corporate/Corporate_Logo_Aldec_Crescent.png)
## Build root filesystem and Linux kernel with using Petalinux

### Requirements
- installed Petalinux 2021.1
- Petalinux 2021.1 BSP for TySOM-2-7Z100 (***TySOM-2-7Z100.bsp***)

### Instruction
Run below steps to recreate a Linux kernel and a Petalinux filesystem. The example uses the Petalinux BSP for TySOM-2-7Z100.

1. Source a Petalinux configuration file
```bash
source <petalinux_installation_path>/petalinux-2021.1/settings.sh
```
2. Create a project with using the BSP.
```bash
petalinux-create -t project -s <path>/TySOM-2-7Z100.bsp
```
3. Go to the project directory
```bash
cd ./TySOM-2-7Z100
```
4. If any changes in the Linux kernel configuration are required then run the command:
```bash
petalinux-config -c kernel
```
5. If any changes in the root filesystem configuration are required then run the command:
```bash
petalinux-config -c rootfs
```
6. Build the project
```bash
petalinux-build
```
7. If the building process is successfully finished then created files should be placed at directory ./images/linux.
Find files uImage and rootfs.cpio.gz.u-boot.

8. Generate the BOOT.BIN file
```bash
petalinux-package --boot --force --fpga --u-boot
```
9. Copy files to a micro SD card.
The micro SD card should contain the following set of files:
- BOOT.BIN (images/linux/BOOT.BIN)
- boot.scr (images/linux/boot.scr)
- system.dtb (images/linux/system.dtb)
- uImage (images/linux/uImage)
- rootfs.cpio.gz.u-boot (images/linux/rootfs.cpio.gz.u-boot)

For root file systems located on second partition copy the following set of files to boot partition:
- BOOT.BIN (images/linux/BOOT.BIN)
- boot.scr (images/linux/boot.scr)
- system.dtb (images/linux/system.dtb)
- uImage (images/linux/uImage)
