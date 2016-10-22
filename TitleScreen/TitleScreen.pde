PImage skeleton, taco, fist;
int x;
boolean meme = false;

void setup(){
 size(1000,400);
skeleton = loadImage("skeleton.png");
taco = loadImage("taco.png");
fist = loadImage("fist.png");
}

void draw() {
startscreen();
if (meme)
   memes();
else 
  gamestate = 2;
}
void startscreen(){
  //background(255);
  textSize(32);
  text("1 Kick Turtle",450,150); 
  
}
void keyPressed() {
  if (key == ' ')
    meme = true;
  else
    meme = false;
  //gamestate = 2;
  }
  
void memes (){
  translate(250,200);
  x++;
  rotate(radians(x));
  image(skeleton,-128,-128); 
}