class Player {
  int pxPos; // player x position
  int pyPos; // player y position
  color pCol = #000000;// player color
  int w = 40; // width
  int h = 40; // height
  boolean jump = false; //if true player is jumping
  boolean duck = false;
  int jStart;
  int dStart;

  Player (int xPos, int yPos) {
    pxPos = xPos;
    pyPos = yPos;
  }


  void display() {
    fill(pCol);
    rect(pxPos, pyPos, w, h);
    if (jump && frameCount - jStart > 60) {
      pyPos += 50;
      jump = false;
    }
    if (duck && frameCount - dStart > 40) {
      pyPos -= 20;
      h +=20;
      duck = false;
    }
  }

  void jump() {
    if (!jump) {
      jump = true;
      pyPos -=50;
      jStart = frameCount;
    }
  }

  void duck() {
    if (!duck && !jump) {
      duck = true;
      pyPos += 20;
      h -= 20;
      dStart = frameCount;
    }
  }
}