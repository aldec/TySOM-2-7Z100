# How to create Vitis 2021.1 application with Aldec platforms

## Table of Content
- [Instruction](#instruction)
  - [Instruction](#instruction)
  - [Build sysroot](#build_sysroot)
  - [Create a project application](#create_a_project_application)

<a name="instruction"/>

## Instruction

<a name="build_sysroot"/>

### Build sysroot

Sysroot is necessary and this chapter demostrates how to download and build it.

1. Download file "ZYNQ common image" from the [Xilinx webpage](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/embedded-design-tools.html)

2. Unpack downloaded file.

3. Install sysroot.
```
$ cd xilinx-zynq-common-v2021.1
$ ./sdk.sh -y -d .
```

4. Sysroot should be available in **xilinx-zynq-common-v2021.1/sysroots/cortexa9t2hf-neon-xilinx-linux-gnueabi/** folder.

5. Post-install DRM headers fix

```
cd xilinx-zynq-common-v2021.1/sysroots/cortexa9t2hf-neon-xilinx-linux-gnueabi/usr/include
xf86drm.h: line 40: change <drm.h> to "drm/drm.h"
xf86drmMode.h: line 43: change <drm.h> to "drm/drm.h"
```

<a name="create_a_project_application"/>

### Create a project application

Now it is possible to create a project application in Vitis:

1. Run Vitis.

2. Select **File -> New -> Application Project...**.

3. Click **Next** on the welcome page.

4. Add the Aldec platform by clicking an icon **Add** and entering a path to the Aldec platform.

5. Select the platform and click **Next**.

6. Enter an application project name. Make sure that target processor is **psu_cortexa53 SMP** and click **Next**.

7. Enter a path to sysroot for aarch64 built in the point 2.

8. Select **Empty Application** or an exemplary apllication. Click **Finish**.

9. Build the application.

10. Copy built files to a SD card and run the Aldec TySOM board.

For example, if for a **hello_world** application project Hardware building configuration was selected, needed files can be available in a directory: **hello_world_system/Hardware/package/sd_card/**

