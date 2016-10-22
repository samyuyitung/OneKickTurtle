class Player {
  int x; // player x position
  int y; // player y position
  color pCol = #000000;// player color
  int w = 50; // width
  int h = 78; // height
  boolean kicking = false; //if true player is jumping
  int kickStart;
  int kickDir = 0; 
  
  PImage turtleNormal;
  PImage turtleLeft;
  PImage turtleRight;
  
  PImage currentImage;

  Player (int xPos, int yPos) {
    x = xPos;
    y = yPos;
    
    turtleNormal = loadImage("images/ninja.jpg");
    turtleLeft = loadImage("images/kickLeft.jpg");
    turtleRight = loadImage("images/kickRight.jpg");
    currentImage = turtleNormal;
  }


  void display() {
    fill(pCol);
    image(currentImage, x, y);
    if (kickDir != 0 && frameCount - kickStart > 5) {
      kickDir = 0;
      currentImage = turtleNormal;
      w = 50;
      x = 475;
    }
  }

  void kick(int dir) {
    if (kickDir == 0) {
      kickDir = dir;
      currentImage = dir == -1 ? turtleLeft : turtleRight;
      kickStart = frameCount;
      w = 100;
      x = 450;
    }
  }
  
  boolean isKicking(){
    return kickDir != 0; 
  }
}