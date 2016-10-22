import processing.serial.*;
boolean sam = false;
Serial myPort;  //the Serial port object
String val;

Player player;

void setup() {
  size(1280, 768);
  noStroke();
  if (sam) {
    myPort = new Serial(this, Serial.list()[1], 9600);
    myPort.bufferUntil('\n');
  }

  player = new Player(200, 618);
}

void draw() {
  arduino();
  background();
  player.display();
}


void arduino() {
  if (sam) {
    if ( myPort.available() > 0) {
      val = myPort.readStringUntil('\n');
      if (val != null)
        println(val);
    }
  }
}
void background() {
  fill(255);
  rect(0, 0, 1280, 768);
  fill(0, 255, 0);
  rect(0, 668, 1280, 100);
}

void keyPressed() {
  if (key == ' ')
    player.jump();
  if (key == 'z')
    player.duck();
  }