// SPDX-License-Identifier: GPL-2.0
/*
 * aldec_hdmi_tysom2.c
 *
 *  Created on: 6 Nov 2023
 *      Author: Pawel Zapalski
 */

#include <stdio.h>

#include "app_hdmi.h"
#include "iic_utils.h"
#include "platform.h"
#include "xil_printf.h"

XIicPs IicPs_inst;
XV_tpg tpg_inst;
XV_tpg_Config *tpg_config;
XVtc VtcInst;
XClk_Wiz ClkWizInst;

XVtc_Timing XVtc_Timingconf;

int main()
{
	int Status;
    init_platform();

	xil_printf(\
			"################################################################################\r\n" \
			"###                         HDMI Example Application                         ###\r\n" \
			"###                             Aldec, Inc. 2023                             ###\r\n" \
			"################################################################################\r\n" \
			);
	xil_printf("TPG application on TySOM-2-7Z100 using on-board HDMI\n\r");

    //Configure the TySOM-2-7Z100 On-board HDMI
	tysom2_set_on_board_hdmi(&IicPs_inst);

    xil_printf("HDMI Setup Complete!\r\n");

    //Initialize the TPG IP
    Status = XV_tpg_Initialize(&tpg_inst, XPAR_V_TPG_0_DEVICE_ID);
    if(Status!= XST_SUCCESS)
    {
    	xil_printf("TPG configuration failed\r\n");
    	return(XST_FAILURE);
    }

    //Initialize the clocking wizard
    XClk_Wiz_Config *ClkWiz_CfgPtr = XClk_Wiz_LookupConfig(XPAR_CLK_WIZ_0_DEVICE_ID);
    XClk_Wiz_CfgInitialize(&ClkWizInst, ClkWiz_CfgPtr, ClkWiz_CfgPtr->BaseAddr);

    //Configure the TPG
    app_hdmi_conf_tpg(&tpg_inst, 1080, 1920, 0x2, XTPG_BKGND_COLOR_BARS);

    //Configure the moving box of the TPG
    app_hdmi_conf_tpg_box(&tpg_inst, 50, 5);

    //Start the TPG
    XV_tpg_EnableAutoRestart(&tpg_inst);
    XV_tpg_Start(&tpg_inst);
    xil_printf("TPG started!\r\n");

    // Initialise the VTC
    XVtc_Config *VTC_Config = XVtc_LookupConfig(XPAR_V_TC_0_DEVICE_ID);
    XVtc_CfgInitialize(&VtcInst, VTC_Config, VTC_Config->BaseAddress);

	// VTC Configuration
	XVtc_ConvVideoMode2Timing(&VtcInst,XVTC_VMODE_1080P,&XVtc_Timingconf);
	XVtc_SetGeneratorTiming(&VtcInst, &XVtc_Timingconf);
	XVtc_RegUpdate(&VtcInst);

	/* End of VTC Configuration */

    // Start the VTC generator
    XVtc_EnableGenerator(&VtcInst);


    // HDMI demonstration with menu
    int config, command;
    int res_x = 1920, res_y = 1080, mode = XVTC_VMODE_1080P;
    u32 pattern = XTPG_BKGND_COLOR_BARS;
    u64 clock = 148500000;

	while (1)
	{
		do
		{
			xil_printf("MENU: Select command:\r\n" \
						"0 - select resolution\r\n" \
						"1 - select pattern\r\n");
			scanf("%d", &command);
		}
		while(command < 0 || command > 1);

		switch(command)
		{
			case 0:
				xil_printf("MENU: Select resolution:\r\n" \
							"1 - 1920x1080\r\n" \
							"2 - 1280x720\r\n" \
							"3 - 800x600\r\n" \
							"4 - 640x480\r\n");
				do
				{
					scanf("%d", &config);
				}
				while(config < 1 || config > 4);

				switch(config)
				{
					case 1: res_x = 1920; res_y = 1080; mode = XVTC_VMODE_1080P;
						clock = 148500000;
						break;
					case 2: res_x = 1280; res_y = 720; mode = XVTC_VMODE_720P;
						clock = 74250000;
						break;
					case 3: res_x = 800; res_y = 600; mode = XVTC_VMODE_SVGA;
						clock = 40000000;
						break;
					case 4: res_x = 640; res_y = 480; mode = XVTC_VMODE_VGA;
						clock = 25175000;
						break;
					default: res_x = 1920; res_y = 1080; mode = XVTC_VMODE_1080P;
						clock = 148500000;
						break;
				}
				xil_printf("INFO: resolution = %dx%d\r\n", res_x, res_y);
				break;
			case 1:
				xil_printf("MENU: Select pattern (range <1-20>): \r\n");
				xil_printf(\
				  "1  - H_RAMP\r\n" \
				  "2  - V_RAMP\r\n" \
				  "3  - TEMPORAL_RAMP\r\n" \
				  "4  - SOLID_RED\r\n" \
				  "5  - SOLID_GREEN\r\n" \
				  "6  - SOLID_BLUE\r\n" \
				  "7  - SOLID_BLACK\r\n" \
				  "8  - SOLID_WHITE\r\n" \
				  "9  - COLOR_BARS\r\n" \
				  "10 - ZONE_PLATE\r\n" \
				  "11 - TARTAN_COLOR_BARS\r\n" \
				  "12 - CROSS_HATCH\r\n" \
				  "13 - RAINBOW_COLOR\r\n" \
				  "14 - HV_RAMP\r\n" \
				  "15 - CHECKER_BOARD\r\n" \
				  "16 - PBRS\r\n" \
				  "17 - DP_COLOR_RAMP\r\n" \
				  "18 - DP_BW_VERTICAL_LINE\r\n" \
				  "19 - DP_COLOR_SQUARE\r\n" \
				  "20 - LAST\r\n" \
				);
				do
				{
					scanf("%lu", &pattern);
				}
				while(pattern < 1 || pattern > 20);

				switch(pattern)
				{
					case XTPG_BKGND_H_RAMP:
					  xil_printf("INFO: pattern = XTPG_BKGND_H_RAMP\r\n"); break;
					case XTPG_BKGND_V_RAMP:
					  xil_printf("INFO: pattern = XTPG_BKGND_V_RAMP\r\n"); break;
					case XTPG_BKGND_TEMPORAL_RAMP:
					  xil_printf("INFO: pattern = XTPG_BKGND_TEMPORAL_RAMP\r\n"); break;
					case XTPG_BKGND_SOLID_RED:
					  xil_printf("INFO: pattern = XTPG_BKGND_SOLID_RED\r\n"); break;
					case XTPG_BKGND_SOLID_GREEN:
					  xil_printf("INFO: pattern = XTPG_BKGND_SOLID_GREEN\r\n"); break;
					case XTPG_BKGND_SOLID_BLUE:
					  xil_printf("INFO: pattern = XTPG_BKGND_SOLID_BLUE\r\n"); break;
					case XTPG_BKGND_SOLID_BLACK:
					  xil_printf("INFO: pattern = XTPG_BKGND_SOLID_BLACK\r\n"); break;
					case XTPG_BKGND_SOLID_WHITE:
					  xil_printf("INFO: pattern = XTPG_BKGND_SOLID_WHITE\r\n"); break;
					case XTPG_BKGND_COLOR_BARS:
					  xil_printf("INFO: pattern = XTPG_BKGND_COLOR_BARS\r\n"); break;
					case XTPG_BKGND_ZONE_PLATE:
					  xil_printf("INFO: pattern = XTPG_BKGND_ZONE_PLATE\r\n"); break;
					case XTPG_BKGND_TARTAN_COLOR_BARS:
					  xil_printf("INFO: pattern = XTPG_BKGND_TARTAN_COLOR_BARS\r\n"); break;
					case XTPG_BKGND_CROSS_HATCH:
					  xil_printf("INFO: pattern = XTPG_BKGND_CROSS_HATCH\r\n"); break;
					case XTPG_BKGND_RAINBOW_COLOR:
					  xil_printf("INFO: pattern = XTPG_BKGND_RAINBOW_COLOR\r\n"); break;
					case XTPG_BKGND_HV_RAMP:
					  xil_printf("INFO: pattern = XTPG_BKGND_HV_RAMP\r\n"); break;
					case XTPG_BKGND_CHECKER_BOARD:
					  xil_printf("INFO: pattern = XTPG_BKGND_CHECKER_BOARD\r\n"); break;
					case XTPG_BKGND_PBRS:
					  xil_printf("INFO: pattern = XTPG_BKGND_PBRS\r\n"); break;
					case XTPG_BKGND_DP_COLOR_RAMP:
					  xil_printf("INFO: pattern = XTPG_BKGND_DP_COLOR_RAMP\r\n"); break;
					case XTPG_BKGND_DP_BW_VERTICAL_LINE:
					  xil_printf("INFO: pattern = XTPG_BKGND_DP_BW_VERTICAL_LINE\r\n"); break;
					case XTPG_BKGND_DP_COLOR_SQUARE:
					  xil_printf("INFO: pattern = XTPG_BKGND_DP_COLOR_SQUARE\r\n"); break;
					case XTPG_BKGND_LAST:
					  xil_printf("INFO: pattern = XTPG_BKGND_LAST\r\n"); break;
				}
				break;
			default:
				xil_printf("Invalid command!\r\n");
		}

		XV_tpg_DisableAutoRestart(&tpg_inst);
		sleep(1);

		/* Calling Clock wizard dynamic reconfig */
		XClk_Wiz_WriteReg(ClkWiz_CfgPtr->BaseAddr, XCLK_WIZ_REG25_OFFSET, 0);
		XClk_Wiz_SetRateHz(&ClkWizInst, clock);

		u32 Reg = 0x0;
		XClk_Wiz_WriteReg(ClkWiz_CfgPtr->BaseAddr, XCLK_US_WIZ_RECONFIG_OFFSET, (XCLK_WIZ_RECONFIG_LOAD | XCLK_WIZ_RECONFIG_SADDR));
		Status = XClk_Wiz_WaitForLock(&ClkWizInst);
		if (Status != XST_SUCCESS) {
			Reg = XClk_Wiz_ReadReg(ClkWiz_CfgPtr->BaseAddr, XCLK_WIZ_STATUS_OFFSET) & CLK_LOCK;
			xil_printf("\n ERROR: Clock is not locked : 0x%x \t Expected "\
			": 0x1\n\r", Reg);
		}

		//Configure the TPG
		app_hdmi_conf_tpg(&tpg_inst, res_y, res_x, 0x2, pattern);

		//Configure the moving box of the TPG
		app_hdmi_conf_tpg_box(&tpg_inst, 50, 5);

		//Start the TPG
		XV_tpg_EnableAutoRestart(&tpg_inst);
		XV_tpg_Start(&tpg_inst);

		/* VTC Configuration */
		XVtc_ConvVideoMode2Timing(&VtcInst,mode,&XVtc_Timingconf);
		XVtc_SetGeneratorTiming(&VtcInst, &XVtc_Timingconf);
		XVtc_RegUpdate(&VtcInst);
	}

    cleanup_platform();
    return 0;
}

