
#include <Servo.h>

Servo servo1; Servo servo2; 


void setup() {

  pinMode(2,OUTPUT);
  servo1.attach(2); //analog pin 0
  //servo1.setMaximumPulse(2000);
  //servo1.setMinimumPulse(700);

  servo2.attach(15); //analog pin 1
  Serial.begin(9600);
  Serial.println("Ready");

}

void loop() {

  static int v = 0;

  if ( Serial.available()) {
    char ch = Serial.read();

    switch(ch) {
      case '0'...'9':
        v = v * 10 + ch - '0';
        break;
      case 's':
        servo1.write(v);
        v = 0;
        break;
      case 'w':
        servo2.write(v);
        v = 0;
        break;
      case 'd':
        servo2.detach();
        break;
      case 'a':
        servo2.attach(15);
        break;
    }
  }

  //Servo::refresh();

} 




/* #include <Stepper.h>

const int stepsPerRevolution = 100;  // change this to fit the number of steps per revolution
// for your motor


// initialize the stepper library on pins 8 through 11:
Stepper myStepper(stepsPerRevolution, 3, 4, 5, 6);

int stepCount = 0;  // number of steps the motor has taken

void setup() {
  // nothing to do inside the setup
}

void loop() {
  // read the sensor value:
  int sensorReading = 120;
  // map it to a range from 0 to 100:
  int motorSpeed = map(sensorReading, 0, 1023, 0, 100);
  // set the motor speed:
  if (motorSpeed > 0) {
    myStepper.setSpeed(motorSpeed);
    // step 1/100 of a revolution:
    myStepper.step(stepsPerRevolution / 100);
  }
}*/
