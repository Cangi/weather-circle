
// controller for Castle Wars

// first joystick pins
const int verticalPin1 = 4; // analog
const int horizontalPin1 = 5; // analog
const int selectPin1 = 2; // digital
const int shotPin1 = 4; // digital
const int ledPin1 = 13; //digital
const int vibratorPin1 = 3; // digital

// second joystick pins
const int verticalPin2 = 0; // analog
const int horizontalPin2 = 1; // analog
const int selectPin2 = 12; // digital
const int shotPin2 = 6; // digital
const int ledPin2 = 10; // digital 
const int vibratorPin2 = 7; // digital

char val; // serial values from processing

void setup() {

  pinMode(selectPin1,INPUT);
  pinMode(selectPin2,INPUT);

  //digitalWrite(selectPin1,HIGH);
  //digitalWrite(selectPin2,HIGH);

  pinMode(ledPin1, OUTPUT);
  pinMode(ledPin2, OUTPUT);

  pinMode(vibratorPin1, OUTPUT);
  pinMode(vibratorPin2, OUTPUT);
  
  pinMode(shotPin1,INPUT);
  pinMode(shotPin2,INPUT);
  
  Serial.begin(9600);
}

void loop() {

  if(Serial.available() > 0) {
    val = Serial.read();

    // p1 LED 
    if(val == 'k') {
      digitalWrite(ledPin1,HIGH);
      delay(1000);
      digitalWrite(ledPin1,LOW);
    }

    // p2 LED 
    if(val == 'l') {
      digitalWrite(ledPin2,HIGH);
      delay(1000);
      digitalWrite(ledPin2,LOW);
    }

    // p1 vibrator 
    if(val == 'v') {
      digitalWrite(vibratorPin1,HIGH);
      delay(1000);
      digitalWrite(vibratorPin1,LOW);
    }  

    // p2 vibrator 
    if(val == 'b') {
      digitalWrite(vibratorPin2,HIGH);
      delay(1000);
      digitalWrite(vibratorPin2,LOW);
    }   
    
  }
  
  else { 
    
  
  // reading the first joystick pins
  int vertical1 = analogRead(verticalPin1);
  int horizontal1 = analogRead(horizontalPin1);
  int select1 = digitalRead(selectPin1);
  int shot1 = digitalRead(shotPin1);
  


  // reading the second joystick pins
  int vertical2 = analogRead(verticalPin2);
  int horizontal2 = analogRead(horizontalPin2);
  int select2 = digitalRead(selectPin2);
  int shot2 = digitalRead(shotPin2);


  int is; // is direction good? 1 true 0 false
  
  // directions for joystick 1
  // u1
  is = 0;
  if(vertical1 > 750) { 
    is = 1;
  } 
  if(is) Serial.println("u1");


  // d1
  is = 0;
  if(vertical1 < 300) { 
    is = 1;
  }
  if(is) Serial.println("d1");


  // r1
  is = 0;
  if(horizontal1 < 300) { 
    is = 1;
  }  
  if(is) Serial.println("r1");


  // l1
  is = 0;
  if(horizontal1 > 750) { 
    is = 1;
  }  
  if(is) Serial.println("l1");

  // button11
  is = 0;
  if(select1 == HIGH) {
    is = 1;
  }
  if(is) { Serial.println("button11");  }

  // button 12
  is = 0;
  if(shot1 == HIGH) {
    is = 1;
  }
  if(is) {
    Serial.println("button12");
  }
  



  // directions for joystick 2
  // u2
  is = 0;
  if(vertical2 > 750) { 
    is = 1;
  } 
  if(is) Serial.println("u2");


  // d2
  is = 0;
  if(vertical2 < 300) { 
    is = 1;
  }
  if(is) Serial.println("d2");


  // r2
  is = 0;
  if(horizontal2 < 300) { 
    is = 1;
  }  
  if(is) Serial.println("r2");


  // l2
  is = 0;
  if(horizontal2 > 750) { 
    is = 1;
  }  
  if(is) Serial.println("l2");


  // button21
  is = 0;
  if(select2 == HIGH) {
    is = 1;
  }
  if(is) { Serial.println("button21");  }


  // button 22
  is = 0;
  if(shot2 == HIGH) {
    is = 1;
  }
  if(is) {
    Serial.println("button22");
  }

  shot2 = shot1 = select2 = select2 = 0;
  
  delay(77); }

}
