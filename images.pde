class Images {
  PImage bruce;
  PImage enemyLeft;
  PImage enemyRight;

  String userImage = "";
  String enemyLeftImage = "images/car.png";
  String enemyRightImage = "images/airplane.jpg";

  Images() {
    //    user = loadImage(userImage);
    enemyLeft = loadImage(enemyLeftImage);
    enemyRight = loadImage(enemyRightImage);
  }
}