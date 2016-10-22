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
    y = 275;
    w = 96;
    h = 25;
    speed = 3;
    image = src; 
  }
  void setPlane(PImage src) {
    y = 200;
    w =97;
    h = 28;
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
  
  
  boolean checkCollide(int px, int py, int pWidth, int pHeight){
    if(px + pWidth >= x && px <= x + w && py + pHeight >= y && py <= y + h)
       return true;
     return false;
    
  }
}