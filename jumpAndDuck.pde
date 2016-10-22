import processing.serial.*;
boolean sam = true;
Serial myPort;  //the Serial port object
String val;
ArrayList<Enemy> enemies;
Images imgs;
boolean newLevel = true;
Player player;

int gameState = 1; //0 start screen, 1 in game, 2 game over
int level = 1;
void setup() {
  size(1000, 400);
  noStroke();
  if (sam) {
    myPort = new Serial(this, Serial.list()[1], 9600);
    myPort.bufferUntil('\n');
  }
  player = new Player(475, 200);
  frameRate(60);
  imgs = new Images();
  enemies = new ArrayList<Enemy>();
}


void draw() {
  arduino();
  if (gameState == 0) {
    startScreen();
  } else if (gameState == 1) {
    if (newLevel)
      loadNewLevel();
    background();
    doEnemys();
    doPlayer();
  }
}

/****** Start game *******/

void startScreen() {
}
/****** end Start game *******/
/******    In game    *******/
void loadNewLevel() {
  for (int i = 0; i < level; i ++){
    enemies.add(getNewEnemy(i));
    println(enemies.get(i).speed);  
}
  newLevel = false;
  level++;
}
Enemy getNewEnemy(int i ) {
  if (((int)random(0,2)) == 0)
    return new Enemy(-50 - (i * 150), 1 * ( level / 5 + 10), imgs.enemyLeft);
  else
    return new Enemy(1000 + (i * 150), -1 * ( level / 5 + 10), imgs.enemyRight);
}
void background() {
  background(255);
  fill(0, 255, 0);
  rect(0, 300, 1000, 100);
}

void doPlayer() {
  player.display();
}
void doEnemys() {
  for (int i = 0; i < enemies.size(); i++) {
    enemies.get(i).display();
    enemies.get(i).move();
    if (enemies.get(i).checkCollide(player.x, player.y, player.w, player.h)) {
      enemies.remove(i);
    }
  }
  if (enemies.size() == 0)
    newLevel = true;
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
          player.punch(1);
        else if (val.equals("DUCK"))
          player.punch(-1);
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
  if (key == 'm')
    player.punch(1);
  if (key == 'z')
    player.punch(-1);
}