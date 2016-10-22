import processing.serial.*;

Serial myPort;  //the Serial port object
String val;
void setup() {
  myPort = new Serial(this, Serial.list()[1], 9600);
  myPort.bufferUntil('\n'); 
}

void draw() {
  if ( myPort.available() > 0) {
    val = myPort.readStringUntil('\n');
    if(val != null)
    println(val);        
  }  
}