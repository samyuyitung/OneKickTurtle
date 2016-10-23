/***********************************************

Controller code for the arduino, this is powered
using interrupts on the buttons the basic setup is

  vcc
   |              interrupt pin
   |                    |
   |---<1kOhm Resistor>---<Button>---|
                                     |
                                    gnd

this basic schematic can repeated for as many inputs as you want

***********************************************/
int lastInput = 0;
void setup() {
  Serial.begin(9600);
  attachInterrupt(0, RIGHT_BUTTON_ISR, FALLING); //Pin 2
  attachInterrupt(1, LEFT_BUTTON_ISR, FALLING); //Pin 3
}

void loop() {
}

void RIGHT_BUTTON_ISR() {
  if (millis() - lastInput > 200) {
    Serial.println("RIGHT");
    lastInput = millis();
  }
}

void LEFT_BUTTON_ISR() {
  if (millis() - lastInput > 200) {
    Serial.println("LEFT");
    lastInput = millis();
  }
}
