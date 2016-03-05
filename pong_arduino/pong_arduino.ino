


const int VERT = 0; 
const int HOR = 1;
const int SEL = 12;

/*const int VERT2 =  5;
const int HOR2 = 4;
const int SEL2 = 2;*/


void setup() {
  
  Serial.begin(9600);
}

void loop() {

  
  int vertical, horizontal, select;
  String verdict = "X";
  String verdict2 = "X2";

  int vertical2, horizontal2, select2;
  
  vertical = analogRead(VERT);
  horizontal = analogRead(HOR);
  //select = digitalRead(SEL);
  
 
 /* vertical2 = analogRead(VERT2);
  horizontal2 = analogRead(HOR2);
  //select2 = analogRead(SEL2);*/

  if(vertical > 650) verdict = "U2";
  if(vertical < 350) verdict = "D2";
  if(horizontal > 650) 
    if(vertical>650) verdict = "U2";
      else if(vertical < 350) verdict = "D2";
  if(horizontal < 350) verdict = "R2";
    if(vertical>650) verdict = "U2";
      else if(vertical < 350) verdict = "D2";

  Serial.println(verdict);

  /*if(vertical2 > 650) verdict2 = "U1";
  if(vertical2 < 350) verdict2 = "D1";
  if(horizontal2 > 650) 
    if(vertical2>650) verdict2 = "U1";
      else if(vertical2 < 350) verdict2 = "D1";
  if(horizontal2 < 350) verdict2 = "R1";
    if(vertical2>650) verdict2 = "U1";
      else if(vertical2 < 350) verdict2 = "D1";
      
  Serial.println(verdict2);*/
  
  delay(37);
}


