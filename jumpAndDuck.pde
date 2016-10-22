import processing.serial.*;
boolean sam = false;
Serial myPort;  //the Serial port object
String val;
ArrayList<Obstacle> obstacles;
Images imgs;
void setup() {
  size(1000, 800);
  if (sam) {
    myPort = new Serial(this, Serial.list()[1], 9600);
    myPort.bufferUntil('\n');
  }
  frameRate(60);
  imgs = new Images();
  obstacles = new ArrayList<Obstacle>();
  obstacles.add(setupObs(new Obstacle(1250)));
}

Obstacle setupObs(Obstacle obs) {
  switch((int) random(0, 2)) {
  case 0: 
    obs.setPlane(imgs.plane);
    break;
  case 1:
    obs.setCar(imgs.car);
    break;
  }
  return obs;
}



void draw() {
  arduino();
  background();
  doObstacles();
}

void doObstacles() {
  for (int i = 0; i < obstacles.size(); i++) {
      println(obstacles.get(i).x);
    obstacles.get(i).display();
    if (!obstacles.get(i).move())
      obstacles.remove(i);
  }
  
    if (frameCount % 45 == 0) {
      obstacles.add(setupObs(new Obstacle(1250)));
    }
}

void arduino() {
  if (sam) {
    if ( myPort.available() > 0) {
      val = myPort.readStringUntil('\n');
      if (val != null)
        if (val.equals("JUMP"))
          println("Jump");
        else if (val.equals("DUCK"))
          println("Ducking");
    }
  }
}

void background() {
  noStroke();
  background(255);
  fill(0, 255, 0);
  rect(0, 700, 1000, 100);
}