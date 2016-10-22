class Rock {
  int x;
  final int y = 650;
  final int SIZE = 50;
  color rockColor = #FFCC00;

  Rock(int x) {
    this.x = x;
  }

  void display() {
    noStroke();
    fill(rockColor);
    rect(x, y, SIZE, SIZE);
  }
  
  void move(){
    x -= 5; 
  }
  
  
}