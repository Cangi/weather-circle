char command;
String string;
boolean ledon = false, once = false, once1=false;
int led = 13;
float pos, previousPos;
int servoPos=0;
void setup()
{
Serial.begin(9600);
previousPos = 0;
}
void loop()
{
  if (Serial.available() > 0)
  {
    string = "";
    once = false;
  }
  while(Serial.available() > 0)
  {
    command = ((byte)Serial.read());
    if(command == ':')
    {
    break;
    }
    else
    {
    string += command;
    }
    delay(1);
  }
  pos = string.toFloat();
  if(!once) {
    //if(pos<1 && pos>0) {
      
      //Serial.println(string);
      //Serial.println(pos);
      once = true;
    //}
  }
  if(previousPos<pos) {
      servoPos--;
      previousPos=pos;
    } else if(previousPos>pos) {
      servoPos++;
      previousPos=pos;
    }
  
  Serial.println(servoPos);

}




void ledOn()
{
  Serial.println("led on");

}
void ledOff()
{
  Serial.println("led off");
}

