class Player {
  int x; // player x position
  int y; // player y position
  int w = 61; // width
  int kickStart;
  int kickDir = 0;

  PImage turtleNormal;
  PImage turtleLeft;
  PImage turtleRight;

  PImage currentImage;

  Player (int xPos, int yPos) {
    x = xPos;
    y = yPos;
	//Since there is only one player the pictures are loaded here,
	// If there are multiple players these should go in the images class.
    turtleNormal = loadImage("images/ninja.jpg");
    turtleLeft = loadImage("images/kickLeft.jpg");
    turtleRight = loadImage("images/kickRight.jpg");
    currentImage = turtleNormal;
  }

  void display() {
    image(currentImage, x, y);
	//Check to see if the kicking is done (after 5 frames)
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
