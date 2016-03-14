char command;
String string;
boolean ledon = false;
int led = 13;
void setup()
{
Serial.begin(9600);

}
void loop()
{
 
if (Serial.available() > 0)
{string = "";
Serial.println("works");
}
while(Serial.available() > 0)
{command = ((byte)Serial.read());

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
if(string == "TO")
{
ledOn();
ledon = true;
}
if(string =="TF")
{
ledOff();
ledon = false;
Serial.println(string); //debug
}
if ((string.toInt()>=0)&&(string.toInt()<=255))
{
if (ledon==true)
{
analogWrite(led, string.toInt());
Serial.println(string); //debug
delay(10);
}
}
}
void ledOn()
{
Serial.println("led on");

}
void ledOff()
{
Serial.println("led off");
}

