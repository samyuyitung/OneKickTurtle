class Obstacle {
  int x = 1000;
  int y;
  
  int w;
  int h;

  int speed;
  
  PImage image;

  Obstacle (int ax){
    x = ax;
  }

  void setCar(PImage src) {
    y = 670;
    w = 100;
    h = 50;
    speed = 3;
    image = src; 
  }
  void setPlane(PImage src) {
    y = 550;
    w = 100;
    h = 50;
    speed = 5;
    image = src;
  }
  
  void display() {
    image(image, x, y);
  }

  boolean move() {
    x -= speed;
    if(x + w + 10 < 0)
      return false;
    else
      return true;
  }
}