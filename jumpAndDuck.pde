import processing.serial.*;
boolean sam = false;
Serial myPort;  //the Serial port object
String val;
Rock[] rocks = new Rock[5];

void setup() {
  size(1000, 800);
  if(sam){
    myPort = new Serial(this, Serial.list()[1], 9600);
    myPort.bufferUntil('\n');
  }
  frameRate(60);
  for(int i = 0; i < rocks.length; i++)
    rocks[i] = new Rock(i * 100);
}

void draw() {
  arduino();
  background();
  doRocks();
}

void doRocks(){
    for(int i = 0; i < rocks.length; i++){
       rocks[i].display();
       rocks[i].move();
    }
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
  background(255);
  fill(0, 255, 0);
  rect(0, 700, 1000, 100);
}