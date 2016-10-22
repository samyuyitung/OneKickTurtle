int leftPin = 3;
int rightPin = 2;
int lastInput = 0;
void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  attachInterrupt(0, RIGHT_BUTTON_ISR, HIGH); //Pin 2
  attachInterrupt(1, LEFT_BUTTON_ISR, HIGH); //Pin 3
//  pinMode(leftPin, INPUT);
//  pinMode(rightPin, INPUT);

}

void loop() {
//  if(digitalRead(leftPin) == LOW)
//      Serial.println("LEFT");
//  else if(digitalRead(rightPin) == LOW)
//        Serial.println("RIGHT");
//
//  delay(50);
}

void RIGHT_BUTTON_ISR() {
  if (millis() - lastInput > 250) {
    Serial.println("RIGHT");
    lastInput = millis();
  }
}

void LEFT_BUTTON_ISR() {
  if (millis() - lastInput > 250) {
    Serial.println("LEFT");
    lastInput = millis();
  }
}
