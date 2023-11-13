// SPDX-License-Identifier: GPL-2.0
/*
 * iic_utils.h
 *
 *  Created on: 26 Nov 2018
 *      Author: florentw
 *
 *  Modified by: Pawel Zapalski
 *      Changes: adaptation for TySOM-2A-7Z100
 */

#ifndef SRC_IIC_UTILS_H_
#define SRC_IIC_UTILS_H_

	#include "tysom2_hw.h"
	#include "xparameters.h"
	#include "xiicps.h"
	#include "sleep.h"
	
	#define IIC_SCLK_RATE		100000

	//ADV7511
	#define ADV7511_HPD_CTRL_MASK	0x40 // bit 6 = state of HPD
	#define ADV7511_HDP_REG_ADDR	0x42


	int ps_iic_init(u16 DeviceId, XIicPs* IicPs);
	int iic_write( XIicPs *IicPs, u8 Address, u8 Data, s32 ByteCount);
	int iic_write2( XIicPs *IicPs, u8 Address, u8 Register, u8 Data );
	int iic_read( XIicPs *IicPs, u8 Address, u8 Register, u8 *Data, int ByteCount);
	void set_iic_mux( XIicPs *IicPs, u8 MuxSelect, u8 Address);
	int check_hdmi_hpd_status(XIicPs *IicPs, u8 Address);
	void configure_adv7511(XIicPs *IicPs, u8 Address);
	void configure_adv7511_tysom2(XIicPs *IicPs, u8 Address);
	void wait_for_monitor(XIicPs *IicPs, u8 Address);
	void tysom2_set_on_board_hdmi(XIicPs *IicPs);

#endif /* SRC_IIC_UTILS_H_ */
