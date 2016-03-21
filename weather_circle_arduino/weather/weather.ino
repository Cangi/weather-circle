#include <Stepper.h>
#include <Servo.h>

#define BAUD 9600


const int stepsPerRevolution = 64 * 32;
const int cityStepperPins[] = { 8, 9, 10, 11};
const int weatherStepperPins[] = { 4, 5, 6, 7};

Stepper cityStepper(stepsPerRevolution, cityStepperPins[0], cityStepperPins[1], cityStepperPins[2], cityStepperPins[3]);
Stepper weatherStepper(stepsPerRevolution / 64, weatherStepperPins[0], weatherStepperPins[1], weatherStepperPins[2], weatherStepperPins[3]);

int stepperSpeed = 7000; // rpm
int stepsAtOnce = 1;

const byte arrowRight = 0;
const byte arrowLeft = 1;

int cityArrow = 0;
int weatherArrow = 0;

boolean select = true;

unsigned long selectStartTime = 0;
unsigned long timeGap = 2000;

Servo servo;
const int servoPin = 2;
int servoPoz;





//CITIES COORDINATES

const int citiesOnDisc = 12;
int cityCoord[citiesOnDisc][2];
int citySteps = stepsPerRevolution / citiesOnDisc;
String cityNames[] = {"Dundee", "Paris", "Vilnius", "Bucharest", "Moscow", "Bangkok", "Tokyo", "Sydney", "Mexico", "LA", "NY", "London"};

void initCityCoord() {

  int gap = 7;

  cityCoord[0][0] = 0;
  cityCoord[0][1] = citySteps;

  for (int i = 1; i < citiesOnDisc; i++) {
    cityCoord[i][0] = cityCoord[i - 1][0] + citySteps;
    cityCoord[i][1] = cityCoord[i - 1][1] + citySteps;
  }
}




//WEATHER COORDINATES
const int weatherOnDisc = 4;
int weatherCoord[weatherOnDisc][2];
int weatherSteps = stepsPerRevolution / weatherOnDisc;
String weatherNames[] = {"sunny", "snowy", "rainy", "cloudy"};

void initWeatherCoord() {
  weatherCoord[0][0] = 0;
  weatherCoord[0][1] = weatherSteps;

  for (int i = 1; i < weatherOnDisc; i++) {
    weatherCoord[i][0] = weatherCoord[i - 1][0] + weatherSteps;
    weatherCoord[i][1] = weatherCoord[i - 1][1] + weatherSteps;
  }
}






void setup() {

  cityStepper.setSpeed(stepperSpeed);
  weatherStepper.setSpeed(700);
  Serial.begin(BAUD);

  initCityCoord();
  initWeatherCoord();

  Serial.println("needArrow");
  delay(100);
  if (Serial.available() > 0) {
    int lastArrow = Serial.parseInt();
    delay(100);
    Serial.print(lastArrow);
    Serial.println(" cacare");
    cityArrow = lastArrow;
  }

  //servo.attach(servoPin);
  flip0();
}


void loop() {
  if (select == true) {
    if (Serial.available() > 0) {
      moveArrow();
    }
    if (checkIfSelected() == true) {
      select = false;
      Serial.print("selected ");
      String cityName = checkForCity();

      if (!cityName.equals("no city"))
      { Serial.println(checkForCity());
        flip180();
      }
      else {
        select = true;
      }
      Serial.print("cityArrow ");
      Serial.println(cityArrow);
      //delay(2000);
    }
  }

  else {

    if (Serial.available() > 0) {
      String weather = Serial.readString();
      Serial.println(weather);
      moveWeatherArrow(weather);
      delay(1000);
      weatherStepper.step(weatherArrow);
    }

    flip0();
    selectStartTime = 0;
    select = true;
  }

}



void moveArrow() {
  byte serialInfo = (byte)Serial.read();
  if (serialInfo == arrowRight) {
    selectStartTime = millis();
    cityStepper.step(stepsAtOnce);
    cityArrow += stepsAtOnce;
    if (cityArrow > stepsPerRevolution) cityArrow = 0;
    Serial.println(checkForCity());
    delay(17);
  }

  else if (serialInfo == arrowLeft) {
    selectStartTime = millis();
    cityStepper.step(-stepsAtOnce);
    cityArrow -= stepsAtOnce;
    if (cityArrow < 0) cityArrow = stepsPerRevolution;
    Serial.println(checkForCity());
    delay(17);

  }
}


void moveWeatherArrow(String weather) {
  int poz;
  for (int i = 0; i < weatherOnDisc; i++) {
    if (weather.equals(weatherNames[i])) {
      poz = i;
      break;
    }
  }

  weatherArrow = (weatherCoord[poz][1] + weatherCoord[poz][0]) / 2;
  weatherStepper.step(-weatherArrow);
}


String checkForCity() {
  for (int i = 0; i < citiesOnDisc; i++)
    if (cityCoord[i][0] < cityArrow && cityCoord[i][1] > cityArrow) {
      return cityNames[citiesOnDisc - i - 1];
    }
  return "no city";
}

void flip180() {
  servoPoz = servo.read();
  while (servoPoz <= 180) {
    servoPoz += 1;
    servo.write(servoPoz);
    delay(50);
  }
}

void flip0() {
  servoPoz = servo.read();
  while (servoPoz >= 0) {
    servoPoz -= 1;
    servo.write(servoPoz);
    delay(50);
  }
}

boolean checkIfSelected() {
  if (selectStartTime == 0) return false;
  if (millis() - selectStartTime > timeGap) return true;
  return false;
}

















