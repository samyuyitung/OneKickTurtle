class Enemy {
  int x; 
  int y;

  int w;

  int dir;
  int speed;

  PImage image;
  boolean isDying;
  int deadTime;

  Enemy (int ax, int aSpeed, PImage src) {
    x = ax;
    w = 50;
    speed = aSpeed;

    if (aSpeed < 0 ) {
      dir = -1;
      y = 170;
    } else {
      dir = 1;
      y = 219;
    }
    image = src;
  }
  void display() {
    image(image, x, y);
  }
  void setDying() {
    deadTime = frameCount;
    speed *= -6;
    isDying = true;
  }
  boolean move() {
    if (isDying)
      y -= (int)random(15,40) *(frameCount - deadTime) - (4.9 * pow(frameCount - deadTime, 2));
    x += speed;

    if (isDying && (x > 1000 || x < -50))
      return false;
    return true;
  }


  boolean checkCollide(int px, int pWidth) {
    if ((dir == -1 && px + pWidth >= x) || (dir == 1 && px <= x + w))
      return true;
    return false;
  }
}