/***************************************

Generic class for holding the images of the enemies
Used so there aren't millions of images loaded for the
game.

***************************************/
class Images {
  PImage enemyLeft;
  PImage enemyRight;
  Images() {
    enemyLeft = loadImage("images/kevin.png");
    enemyRight = loadImage("images/droid.jpg");
  }
}
