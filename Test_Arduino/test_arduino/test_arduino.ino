#include <Servo.h>
Servo servo; // Define our Servo
int poz;
boolean goRight = false;

void setup()
{
  //servo.attach(13); // servo on digital pin 10
  //servo.write(180);
   poz = 180;
   
}

void loop()
{
  /*if(poz < 0) { 
    goRight = true;
    }
    
  if(poz > 180) {
    goRight = false;
  }
  
  if(!goRight) {
    poz-=7;
    servo.write(poz);
  }
  
  else {
    poz+=7;
    servo.write(poz);
  }
  
   delay(50);*/
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
