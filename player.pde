class Player {
  int x; // player x position
  int y; // player y position
  color pCol = #000000;// player color
  int w = 50; // width
  int h = 100; // height
  boolean punching = false; //if true player is jumping
  int punchStart;
  int punchDir = 0; 

  Player (int xPos, int yPos) {
    x = xPos;
    y = yPos;
  }


  void display() {
    fill(pCol);
    rect(x, y, w, h);
    if (punchDir != 0 && frameCount - punchStart > 30) {
      punchDir = 0;
    }
  }

  void punch(int dir) {
    if (punchDir == 0) {
      punchDir = dir;
      punchStart = frameCount;
    }
  }
}