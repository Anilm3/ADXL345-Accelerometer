// sudo ln -s /dev/ttyACM0 /dev/ttyS8

import processing.serial.*;

Serial myPort;        // The serial port

int pitch = 0;
int roll = 0;
int step = 0;
void setup () 
{
	// set the window size:
	size(640, 360, P3D); 
	//noStroke();   
	// List all the available serial ports
	println(Serial.list());
	// I know that the first port in the serial list on my mac
	// is always my  Arduino, so I open Serial.list()[0].
	// Open whatever port is the one you're using.
	myPort = new Serial(this, Serial.list()[0], 9600);
	// don't generate a serialEvent() unless you get a newline character:
	myPort.bufferUntil('\n');
	// set inital background:

}

void draw () 
{

	background(0.5);

	pushMatrix(); 

	translate(width/2, height/2, -30); 

	rotateX(((float)-pitch)*PI/180.0); 
	rotateZ(((float)-roll)*PI/180.0); 
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

void serialEvent (Serial myPort) 
{
  	// get the ASCII string:
	String xs = myPort.readStringUntil('\n');
	if (xs != null) {

		// trim off any whitespace:
		xs = trim(xs);
		// convert to an int and map to the screen height:
		float x = float(xs); 
		if (step == 0) {
			pitch = ((int)x);
			step = 1;
		} else {
			roll = ((int)x);
			step = 0;
		}
	}
}
