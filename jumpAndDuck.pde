
import processing.serial.*;


int testing = 0;
boolean sam = true;
Serial myPort;  //the Serial port object
String val;
ArrayList<Enemy> enemies;
Images imgs;
int score;
boolean newLevel = true;
Player player;
int gameState = 0; //0 start screen, 2 in game, 3 game over

int level = 0;
int pregameDelay;
int deathTime;
int lastInput = 0;
PImage skeleton;
boolean meme = false;
int skeletonRotation;

PFont comicSans;

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
  comicSans = loadFont("ComicSansMS-48.vlw");
}

void draw() {
  arduino();
  if (gameState == 0) {
    startScreen();
  } else if (gameState == 1) {
    ui();
    doPlayer();
    if (timeSince(pregameDelay) < 179) {
      countDown();
    } else {
      if (newLevel)
        loadNewLevel();
      doEnemys();
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
  textFont(comicSans);
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
  level++;
  for (int i = 0; i < level; i ++) 
    enemies.add(getNewEnemy(i));

  newLevel = false;
}
Enemy getNewEnemy(int i ) {
  if (((int)random(0, 2)) == 0)
    return new Enemy(-50 - (i * 200), 1 * ( level / 3 + 10), imgs.enemyLeft);
  else
    return new Enemy(1000 + (i * 200), -1 * ( level / 3 + 10), imgs.enemyRight);
}
void ui() {
  background(255);
  fill(0, 255, 0);
  rect(0, 300, 1000, 100);
  textSize(30);
  text("Score : " + score, 800, 50);
  text("Wave  : " + (level == 0 ? "" : level), 800, 90);
}

void doPlayer() {
  player.display();
}

void doEnemys() {
  for (int i = 0; i < enemies.size(); i++) {
    enemies.get(i).display();
    if (enemies.get(i).checkCollide(player.x, player.w)) {
      if (player.isKicking() && enemies.get(i).dir == (-1 * player.kickDir)) {
        enemies.get(i).setDying();
        ++score;
      } else {
        deathTime = frameCount;
        gameState = 2;
        return;
      }
    }
    if (!enemies.get(i).move()) {
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
  text("You lose", 300, 100);
  text("You Made it to wave " + level, 300, 140);
  
  fill(#FF0000);
  text("Press the red\nbutton to restart", 300, 220);
}
/***** Utils *****/

void arduino() {
  if (sam) {
    if ( myPort.available() > 0 && timeSince(lastInput) > 5) {
      val = myPort.readStringUntil('\n');
      if (val != null) {
        lastInput = frameCount;
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
  enemies.clear();
  level = 1;
  gameState = 1;
  score = 0;
}


void keyPressed() {
  if (key == 'm')
    player.kick(1);
  if (key == 'z')
    player.kick(-1);
}

int timeSince(int time) {
  return frameCount - time;
}