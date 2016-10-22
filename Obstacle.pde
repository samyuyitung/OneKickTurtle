class Obstacle {
  int x = 1000;
  int y;
  
  int w;
  int h;

  int speed;

  color kolor;

  Obstacle (int ax){
    x = ax;
  }

  void setCar() {
    y = 600;
    w = 50;
    h = 50;
    speed = 3;
    kolor = #FF0000;
  }
  void setPlane() {
    y = 550;
    w = 50;
    h = 50;
    speed = 5;
    kolor = #FF0000;
  }
  
  void display() {
    noStroke();
    fill(kolor);
    rect(x, y, w, h);
  }

  boolean move() {
    x -= speed;
    if(x < 0)
      return false;
    else
      return true;
  }
}