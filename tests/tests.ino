


const int VERT = 0; 
const int HOR = 2;
const int SEL = 7;

const int VERT2 =  1;
const int HOR2 = 3;
const int SEL2 = 11;

const int ldr = 4;

const int pot = 5;

void setup() {
  /*pinMode(SEL,INPUT_PULLUP);
  pinMode(SEL2, INPUT_PULLUP);
  digitalWrite(SEL,HIGH);
  digitalWrite(SEL2,HIGH);*/

  
  
  Serial.begin(9600);
}

void loop() {



  int caineprost = analogRead(ldr);

  if(caineprost < 250) Serial.println(caineprost);
  if(caineprost > 700) Serial.println(caineprost);
  int x = analogRead(pot);
  int balaur;

  if(x<100) balaur = 0;
  else if (x<200) balaur = 2;
    else if (x<300) balaur = 4;
      else if (x<400) balaur = 6;
        else if (x<500) balaur = 8;
          else if (x<600) balaur = 10;
            else if (x<700) balaur = 12;
              else if (x<800) balaur = 14;
                else if (x<900) balaur = 16;
                  else balaur = 30;
  
  int vertical, horizontal, select;
  String verdict = "X";
  String verdict2 = "X2";

  int vertical2, horizontal2, select2;
  
  vertical = analogRead(VERT);
  horizontal = analogRead(HOR);
  //select = digitalRead(SEL);
  

  vertical2 = analogRead(VERT2);
  horizontal2 = analogRead(HOR2);
  //select2 = analogRead(SEL2);

  if(vertical > 650) verdict = "U2";
  if(vertical < 350) verdict = "D2";
  if(horizontal > 650) verdict = "L2";
  if(horizontal < 350) verdict = "R2";
  //if(select == LOW) verdict = "S2";
  Serial.println(verdict);

  if(vertical2 > 650) verdict2 = "U1";
  if(vertical2 < 350) verdict2 = "D1";
  if(horizontal2 > 650) verdict2 = "L1";
  if(horizontal2 < 350) verdict2 = "R1";
 // if(select2 == LOW) verdict2 = "S2";
  Serial.println(verdict2);

  Serial.println(balaur);
  
  delay(100);
}


