import processing.serial.*;
boolean sam = false;
Serial myPort;  //the Serial port object
String val;
void setup() {
  size(1280, 768);
  if(sam){
    myPort = new Serial(this, Serial.list()[1], 9600);
    myPort.bufferUntil('\n');
  }
}

void draw() {
  arduino();
  background();
}


void arduino() {
  if(sam){
    if ( myPort.available() > 0) {
      val = myPort.readStringUntil('\n');
      if (val != null)
        println(val);
    }
  }
}
void background() {
  noStroke();
  fill(255);
  rect(0, 0, 1280, 768);
  fill(0, 255, 0);
  rect(0, 668, 1280, 100);
}