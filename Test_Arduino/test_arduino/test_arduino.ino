#include <Servo.h>
#include <Stepper.h>

Servo servo; // Define our Servo
int poz;
boolean goRight = false;
const int stepsPerRevolution = 32;  // change this to fit the number of steps per revolution

Stepper myStepper(stepsPerRevolution, 8, 9, 10, 11);
Stepper myStepper1(stepsPerRevolution, 4, 5, 6, 7);

void setup()
{
  myStepper.setSpeed(700);
  myStepper1.setSpeed(700);
  //servo.attach(2); // servo on digital pin 10
  //reposition();
}

void reposition() {
  poz = servo.read();
  while (poz > 0) {
    poz -= 5;
    servo.write(poz);
    delay(150);
  }
}

void loop()
{
  if (poz < 0) {
    goRight = true;
  }

  if (poz > 180) {
    goRight = false;
  }

  if (!goRight) {
    poz -= 10;
    servo.write(poz);
  }


  else {
    poz += 10;
    servo.write(poz);
  }
  delay(35);

  // step one revolution  in one direction:
  Serial.println("clockwise");
  myStepper1.step(stepsPerRevolution * 32);

  // step one revolution in the other direction:
  Serial.println("counterclockwise");
  myStepper1.step(-stepsPerRevolution * 32);



  // step one revolution  in one direction:
  Serial.println("clockwise");
  myStepper.step(stepsPerRevolution * 32);

  // step one revolution in the other direction:
  Serial.println("counterclockwise");
  myStepper.step(-stepsPerRevolution * 32);

}




