import processing.serial.*;
boolean sam = true;
Serial myPort;  //the Serial port object
String val;
ArrayList<Obstacle> obstacles;
Images imgs;

Player player;

int gameState = 1; //0 start screen, 1 in game, 2 game over

void setup() {
  size(1000, 400);
  noStroke();
  if (sam) {
    myPort = new Serial(this, Serial.list()[1], 9600);
    myPort.bufferUntil('\n');
  }
  player = new Player(200, 250);
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
  if (gameState == 0) {
    startScreen();
  } else if (gameState == 1) {
    background();
    doObstacles();
    doPlayer();
  }
}
/****** Start game *******/

void startScreen() {
}
/****** end Start game *******/
/******    In game    *******/
void background() {
  background(255);
  fill(0, 255, 0);
  rect(0, 300, 1000, 100);
}

void doPlayer() {
  player.display();
}
void doObstacles() {
  for (int i = 0; i < obstacles.size(); i++) {
    obstacles.get(i).display();
    if (!obstacles.get(i).move())
      obstacles.remove(i);
    if (obstacles.get(i).checkCollide(player.pxPos, player.pyPos, player.w, player.h))
      gameState = 2;
  }

  if (frameCount % 45 == 0) {
    obstacles.add(setupObs(new Obstacle(1050)));
  }
}


/***** end in game *****/

/***** Utils *****/

void arduino() {
  if (sam) {
    if ( myPort.available() > 0) {
      val = myPort.readStringUntil('\n');
      if (val != null) {
        val = trim(val);
        println("/" + val + "/");
        if (val.equals("JUMP"))
          player.jump();
        else if (val.equals("DUCK"))
          player.duck();
      }
    }
  }
}

void jumpPressed() {
  if (gameState == 0) {
    gameState = 1;
  }
}

void keyPressed() {
  if (key == ' ')
    player.jump();
  if (key == 'z')
    player.duck();
}