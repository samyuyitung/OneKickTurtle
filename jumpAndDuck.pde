import processing.serial.*;
boolean sam = true;
Serial myPort;  //the Serial port object
String val;
ArrayList<Enemy> enemies;
Images imgs;
boolean newLevel = true;
Player player;

int gameState = 0; //0 start screen, 2 in game, 3 game over
int level = 1;
int pregameDelay;
int deathTime;

PImage skeleton;
boolean meme = false;
int skeletonRotation;
void setup() {
  size(1000, 400);
  skeleton = loadImage("images/skeleton.png");

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
    if (timeSince(pregameDelay) < 179) {
      makeBackground();
      doPlayer();
      countDown();
    } else {
      if (newLevel)
        loadNewLevel();
      makeBackground();
      doEnemys();
      doPlayer();
    }
  } else if (gameState == 2) {
    gameOverScreen();
  }
}

/****** Start game *******/
void memes () {
  translate(250, 200);
  skeletonRotation++;
  rotate(radians(skeletonRotation));
  image(skeleton, -128, -128);
}
void startScreen() {
  background(0);
  textSize(32);
  fill(255);
  text("1 Kick Turtle", 450, 150); 
  fill((frameCount / 30 % 2) == 1 ? 0 : #FF0000);
  text("Press the red\nbutton to start!", 450, 250);
  if (meme)
    memes();
}
/****** end Start game *******/
/******    In game    *******/
void countDown() {
  text("" + (3 -(timeSince(pregameDelay)) / 60), 100, 100);
}

void loadNewLevel() {
  for (int i = 0; i < level; i ++) 
    enemies.add(getNewEnemy(i));

  newLevel = false;
  level++;
}
Enemy getNewEnemy(int i ) {
  if (((int)random(0, 2)) == 0)
    return new Enemy(-50 - (i * 200), 1 * ( level / 5 + 10), imgs.enemyLeft);
  else
    return new Enemy(1000 + (i * 200), -1 * ( level / 5 + 10), imgs.enemyRight);
}
void makeBackground() {
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
    if (enemies.get(i).checkCollide(player.x, player.w)) {
      if (player.isKicking() && enemies.get(i).dir == (-1 * player.kickDir)){
        enemies.get(i).setDying();
      }
      else {
        deathTime = frameCount;
        gameState = 2;
        return;
      }
    }
    if(!enemies.get(i).move()){
      enemies.remove(i);
    }
  }
  if (enemies.size() == 0)
    newLevel = true;
}


/***** end in game *****/
void gameOverScreen() {
  enemies.clear();
  background(0);
  fill(255);
  text("You lose", 100, 100);
  text("Press the red button to restart", 100, 150);
}
/***** Utils *****/

void arduino() {
  if (sam) {
    if ( myPort.available() > 0) {
      val = myPort.readStringUntil('\n');
      if (val != null) {
        val = trim(val);
        if (val.equals("LEFT"))
          jumpPressed();
        else if (val.equals("RIGHT"))
          duckPressed();
      }
    }
  }
}

void jumpPressed() {
  if (gameState == 0) {
    gameState = 1;
    pregameDelay = frameCount;
  } else if (gameState == 1) 
    player.kick(1);
  else if (gameState == 2 && timeSince(deathTime) > 60)
    resetGame();
}

void duckPressed() {
  if (gameState == 0)
    meme = true;
  else if ( gameState == 1) 
    player.kick(-1);
}

void resetGame() {
  pregameDelay = frameCount;
  level = 1;
  gameState = 1;
}


void keyPressed() {
  if (key == 'm')
    player.kick(1);
  if (key == 'z')
    player.kick(-1);
}

int timeSince(int time){
  return frameCount - time;
}