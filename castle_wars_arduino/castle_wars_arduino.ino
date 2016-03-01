
// controller for Castle Wars

const int verticalPin = 0; // analog
const int horizontalPin = 1; // analog
const int selectPin = 2; // digital

void setup() {
  pinMode(SEL,INPUT_PULLUP);
  digitalWrite(SEL,HIGH);
  Serial.begin(9600);
}

void loop() {
  int vertical = analogRead(verticalPin);
  int horizontal = analogRead(horizontalPin);
  int select = digitalRead(selectPin);
  
}
