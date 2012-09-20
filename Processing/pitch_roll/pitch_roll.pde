/********************************************************************************
* ADXL345 Library Examples- pitch_roll.pde                                      *
*                                                                               *
* Copyright (C) 2012 Anil Motilal Mahtani Mirchandani(anil.mmm@gmail.com)       *
*                                                                               *
* License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html> *
* This is free software: you are free to change and redistribute it.            *
* There is NO WARRANTY, to the extent permitted by law.                         *
*                                                                               *
*********************************************************************************/

// If you are working with Arduino Mega
// sudo ln -s /dev/ttyACM0 /dev/ttyS8

import processing.serial.*;

Serial fd;

int pitch = 0;
int roll = 0;

void setup () 
{
	size(640, 360, P3D); 
	//Connect to the corresponding serial port
	fd = new Serial(this, Serial.list()[0], 9600);
	// Defer callback until new line
	fd.bufferUntil('\n');
}

void draw () 
{
	//Set background
	background(0.5);

	pushMatrix(); 
	
	translate(width/2, height/2, -30); 

	//Rotate
	rotateX(((float)pitch)*PI/180.0); 
	rotateZ(((float)roll)*PI/180.0); 

	//Print data
	print("Pitch: ");
	print(pitch);
	print(", Roll: ");
	println(roll);

	
	scale(90);
	beginShape(QUADS);

	fill(0, 255, 0); vertex(-1,  1,  1);
	fill(0, 255, 0); vertex( 1,  1,  1);
	fill(0, 255, 0); vertex( 1, -1,  1);
	fill(0, 255, 0); vertex(-1, -1,  1);

	fill(0, 255, 255); vertex( 1,  1,  1);
	fill(0, 255, 255); vertex( 1,  1, -1);
	fill(0, 255, 255); vertex( 1, -1, -1);
	fill(0, 255, 255); vertex( 1, -1,  1);


	fill(255, 0, 255); vertex( 1,  1, -1);
	fill(255, 0, 255); vertex(-1,  1, -1);
	fill(255, 0, 255); vertex(-1, -1, -1);
	fill(255, 0, 255); vertex( 1, -1, -1);

	fill(255, 255, 0); vertex(-1,  1, -1);
	fill(255, 255, 0); vertex(-1,  1,  1);
	fill(255, 255, 0); vertex(-1, -1,  1);
	fill(255, 255, 0); vertex(-1, -1, -1);


	fill(255, 0, 0); vertex(-1,  1, -1);
	fill(255, 0, 0); vertex( 1,  1, -1);
	fill(255, 0, 0); vertex( 1,  1,  1);
	fill(255, 0, 0); vertex(-1,  1,  1);


	fill(0, 0, 255); vertex(-1, -1, -1);
	fill(0, 0, 255); vertex( 1, -1, -1);
	fill(0, 0, 255); vertex( 1, -1,  1);
	fill(0, 0, 255); vertex(-1, -1,  1);


	endShape();

	popMatrix(); 
}

void serialEvent (Serial fd) 
{
	// get the ASCII string:
	String rpstr = fd.readStringUntil('\n');
	if (rpstr != null) {
		String[] list = split(rpstr, ':');
		pitch = ((int)float(list[0]));
		roll = ((int)float(list[1]));
	}
}
