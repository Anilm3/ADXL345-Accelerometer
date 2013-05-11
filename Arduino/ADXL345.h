/********************************************************************************
* ADXL345 Library - ADXL345.h                                                   *
*                                                                               *
* Copyright (C) 2012 Anil Motilal Mahtani Mirchandani(anil.mmm@gmail.com)       *
*                                                                               *
* License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html> *
* This is free software: you are free to change and redistribute it.            *
* There is NO WARRANTY, to the extent permitted by law.                         *
*                                                                               *
*********************************************************************************/

#ifndef _ADXL345_H
#define _ADXL345_H

#include <Arduino.h>

// All functions return -1 on error and 0 on success
class ADXL345
{
	private:
		/* ADXL345 Registers */
		enum info_t 
		{
			DEVID          = 0x00,
			THRESH_TAP     = 0x1D,
			OFSX           = 0x1E,
			OFSY           = 0x1F,
			OFSZ           = 0x20,
			DUR            = 0x21,
			Latent         = 0x22,
			Window         = 0x23,
			THRESH_ACT     = 0x24,
			THRESH_INACT   = 0x25,
			TIME_INACT     = 0x26,
			ACT_INACT_CTL  = 0x27,
			THRESH_FF      = 0x28,
			TIME_FF        = 0x29,
			TAP_AXES       = 0x2A,
			ACT_TAP_STATUS = 0x2B,
			BW_RATE        = 0x2C,
			POWER_CTL      = 0x2D,
			INT_ENABLE     = 0x2E,
			INT_MAP        = 0x2F,
			INT_SOURCE     = 0x30,
			DATA_FORMAT    = 0x31,
			DATAX0         = 0x32,
			DATAX1         = 0x33,
			DATAY0         = 0x34,
			DATAY1         = 0x35,
			DATAZ0         = 0x36,
			DATAZ1         = 0x37,
			FIFO_CTL       = 0x38,
			FIFO_STATUS    = 0x39,
			ADDRESS        = 0xA7 >> 1
		};


		int zG[3];
		int readRegister(byte reg_addr, int nbytes, byte *buffer);
		int writeRegister(byte reg_addr, int nbytes, byte *buffer);
	
	public:
		enum range_t
		{
			RANGE_16G = 0x0B,
			RANGE_8G  = 0x0A,
			RANGE_4G  = 0x09,
			RANGE_2G  = 0x08
		};

		ADXL345();
	
		void begin();
		void end();
	
		//G Reading
		void read(double *x, double *y, double *z);
	
		//Raw reading
		void read(int *x, int *y, int *z);
	
		//Unit must be res_t
		void setRange(range_t range);

		//Unit must be G
		void setZeroG(double x, double y, double z);
	
		//Unit must be "Raw"
		void setZeroG(int x, int y, int z);
};

#endif // _ADXL345_H
