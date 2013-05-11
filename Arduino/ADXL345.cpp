/********************************************************************************
* ADXL345 Library - ADXL345.cpp                                                 *
*                                                                               *
* Copyright (C) 2012 Anil Motilal Mahtani Mirchandani(anil.mmm@gmail.com)       *
*                                                                               *
* License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html> *
* This is free software: you are free to change and redistribute it.            *
* There is NO WARRANTY, to the extent permitted by law.                         *
*                                                                               *
*********************************************************************************/

#include <ADXL345.h>
#include <Wire.h>

int ADXL345::writeRegister(byte reg_addr, int nbytes, byte *buffer)
{
	int written_bytes;
	
	Wire.beginTransmission(ADXL345::ADDRESS);
	Wire.write(reg_addr);
	written_bytes = Wire.write(buffer, nbytes);
	Wire.endTransmission();
	
	return written_bytes;
}

int ADXL345::readRegister(byte reg_addr, int nbytes, byte *buffer)
{
	int idx = 0;

	Wire.beginTransmission(ADXL345::ADDRESS);
	Wire.write(reg_addr);
	Wire.endTransmission(); 
	
	Wire.requestFrom(ADXL345::ADDRESS, nbytes);

	while(Wire.available() && idx < nbytes)
	{ 
		buffer[idx++] = Wire.read();
	}
	
	return idx;
}

ADXL345::ADXL345()
{
	Wire.begin();
	
	zG[0] = -20;
	zG[1] =  15;
	zG[2] = -23;
}

void ADXL345::begin()
{
	byte data = 0x08;
	writeRegister(ADXL345::POWER_CTL, 1, &data);
}

void ADXL345::end()
{
	byte data = 0x00;
	writeRegister(ADXL345::POWER_CTL, 1, &data);
}

void ADXL345::read(double *x, double *y, double *z)
{
	byte buffer[6];

	readRegister(ADXL345::DATAX0, 6, buffer);
	
	*x = ((buffer[0] + (buffer[1] << 8)) - zG[0])/256.0;
	*y = ((buffer[2] + (buffer[3] << 8)) - zG[1])/256.0;
	*z = ((buffer[4] + (buffer[5] << 8)) - zG[2])/256.0;
}

void ADXL345::read(int *x, int *y, int *z)
{
	byte buffer[6];

	readRegister(ADXL345::DATAX0, 6, buffer);
	
	*x = buffer[0] + (buffer[1] << 8);
	*y = buffer[2] + (buffer[3] << 8);
	*z = buffer[4] + (buffer[5] << 8);
}


void ADXL345::setRange(range_t range)
{	
	switch(range)
	{
		case RANGE_16G:
		case RANGE_8G:
		case RANGE_4G:
		case RANGE_2G:
			writeRegister(ADXL345::DATA_FORMAT, 1, (byte *)&range);
			break;
	}
}

void ADXL345::setZeroG(double x, double y, double z)
{
	zG[0] = x*256.0;
	zG[1] = y*256.0;
	zG[2] = z*256.0;
}

void ADXL345::setZeroG(int x, int y, int z)
{
	zG[0] = x;
	zG[1] = y;
	zG[2] = z;
}
