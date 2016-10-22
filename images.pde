class Images {
  PImage user;
  PImage car;
  PImage plane;

  String userImage = "";
  String carImage = "images/car.png";
  String planeImage = "images/airplane.jpg";

  Images() {
    //    user = loadImage(userImage);
    car = loadImage(carImage);
    plane = loadImage(planeImage);
  }
}