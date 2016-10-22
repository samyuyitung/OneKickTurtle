class Enemy {
  int x; 
  int y;
  
  int w;
  int h;
  
  int dir;
  int speed;
  
  PImage image;

  Enemy (int ax, int aSpeed, PImage src){
    x = ax;
    y = 250;
    w = 96;
    h = 25;
    speed = aSpeed;
    
    if (aSpeed < 0 ) 
      dir = -1;
    else
      dir = 1;
    image = src; 
  }
  void display() {
    image(image, x, y);
  }

  void move() {
    x += speed;
  }
  
  
  boolean checkCollide(int px, int py, int pWidth, int pHeight){
    if((dir == -1 && px + pWidth >= x) || (dir == 1 && px <= x + w))
       return true;
     return false;
    
  }
}