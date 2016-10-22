int jumpPin = 2;
int duckPin = 3;
int lastJump, lastDuck;
void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  attachInterrupt(0, JUMP_BUTTON_ISR, HIGH); //Pin 2
  attachInterrupt(1, DUCK_BUTTON_ISR, HIGH); //Pin 3

}

void loop() {

}

void JUMP_BUTTON_ISR() {
  if (millis() - lastJump > 250) {
    Serial.println("LEFT");
    lastJump = millis();
  }
}

void DUCK_BUTTON_ISR() {
  if (millis() - lastDuck > 250) {
    Serial.println("RIGHT");
    lastDuck = millis();
  }
}
