/*#include <Servo.h>
Servo servo; // Define our Servo
int poz;
boolean goRight = false;

void setup()
{
  servo.attach(2); // servo on digital pin 10
  reposition();
}

void reposition() {
  poz = servo.read();
  while(poz > 0) {
    poz-=5;
    servo.write(poz);
    delay(150);
  }
}

void loop()
{
  if(poz < 0) { 
    goRight = true;
    servo.detach();
    delay(3000);
    servo.attach(2);
    }
    
  if(poz > 180) {
    goRight = false;
    servo.detach();
    delay(3000);
    servo.attach(2);
  }
  
  if(!goRight) {
    poz-=1;
    servo.write(poz);
  }
  
  else {
    poz+=1;
    servo.write(poz);
  }
  
   delay(35);
}*/





#include <Stepper.h>

const int stepsPerRevolution = 32;  // change this to fit the number of steps per revolution
// for your motor

// initialize the stepper library on pins 8 through 11:
Stepper myStepper(stepsPerRevolution, 4, 5, 6, 7);

void setup() {
  // set the speed at 60 rpm:
  myStepper.setSpeed(700);
  // initialize the serial port:
  Serial.begin(9600);
}

void loop() {
  // step one revolution  in one direction:
  Serial.println("clockwise");
  myStepper.step(stepsPerRevolution*32);
  delay(500);

  // step one revolution in the other direction:
  Serial.println("counterclockwise");
  myStepper.step(-stepsPerRevolution*32);
  delay(500);
}

