import processing.serial.*;
boolean sam = false;
Serial myPort;  //the Serial port object
String val;

Player player;
Obstacle[] obstacles = new Obstacle[5];

void setup() {
  size(1000, 800);
  noStroke();
  if (sam) {
    myPort = new Serial(this, Serial.list()[1], 9600);
    myPort.bufferUntil('\n');
  }
  player = new Player(200, 618);
  frameRate(60);
  for (int i = 0; i < obstacles.length; i++) {
    obstacles[i] = new Obstacle(width + (i * (width / obstacles.length)));
    setupObs(obstacles[i]);
  }
}

void setupObs(Obstacle obs) {
  switch((int) random(0, 2)) {
  case 0: 
    obs.setPlane();
    break;
  case 1:
    obs.setCar();
    break;
  }
}



void draw() {
  arduino();
  background();
  player.display();
  doObstacles();
}

void doObstacles() {
  for (int i = 0; i < obstacles.length; i++) {
    obstacles[i].display();
    if (!obstacles[i].move())
      reincarnate(obstacles[i]);
  }
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
  background(255);
  fill(0, 255, 0);
  rect(0, 700, 1000, 100);
}

void reincarnate(Obstacle obs) {
  obs.x = 1000;
  setupObs(obs);
}

void keyPressed() {
  if (key == ' ')
    player.jump();
  if (key == 'z')
    player.duck();
}