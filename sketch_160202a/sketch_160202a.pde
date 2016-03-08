import processing.serial.*;
import java.util.*;

Serial myPort;
String input;

int speed = 3, screenX=1000, screenY=500;
int x1 = 10, y1 = 10;
int x2 = screenX - 10, y2 = screenY - 60;

int red, green, blue;

boolean isThereACandy = false; // wtf is this

String dir = "L";
String dir2 = "R2";

int nebunie = 0;

boolean testIfNumber(String s) {
  try{ 
    int x = Integer.parseInt(s);
    return true; }
    catch(Exception e) {
      return false;
    }
}


void setup()
{
  red = 50;
  green = 132;
  blue = 56;
  size(screenX, screenY);
  try {
    myPort = new Serial(this, Serial.list()[1], 9600);
  }
  catch(Exception e) {
    println("arduino board is not connected properly");
  }
}

void draw()
{  
  if(x1>screenX)  x1=0; 
  if(x1<0) x1=screenX; 
  if(y1>screenY)  y1=0; 
  if(y1<0)  y1=screenY;
  
  if(x2>screenX)  x2=0; 
  if(x2<0) x2=screenX; 
  if(y2>screenY)  y2=0; 
  if(y2<0)  y2=screenY;
  
  
  
  background(green, blue, red);
  fill(red, green, blue);
  rect(x1, y1, 50, 50);
  fill(blue, red, green);
  rect(x2, y2, 50, 50);
  
  
  
  
  /*if(nebunie == 5) {
    Random random = new Random();
    int x = random.nextInt(7);
    x++;
    if(x == 1) dir = "R";
    if(x == 2) dir = "L";
    if(x == 3) dir = "U";
    if(x == 4) dir = "D";
    
    x = random.nextInt(7);
    x++;
    if(x == 1) dir2 = "R2";
    if(x == 2) dir2 = "L2";
    if(x == 3) dir2 = "U2";
    if(x == 4) dir2 = "D2";
  }*/
  
  
  if(dir.equals("R")) x1+=speed;
  if(dir.equals("L")) x1-=speed;
  if(dir.equals("U")) y1-=speed;
  if(dir.equals("D")) y1+=speed;
  
  if(dir2.equals("R2")) x2+=speed;
  if(dir2.equals("L2")) x2-=speed;
  if(dir2.equals("U2")) y2-=speed;
  if(dir2.equals("D2")) y2+=speed;
  

  
  if(myPort.available() > 0) {
    input = myPort.readStringUntil('\n'); 
    if(input != null) {
      input = input.trim();
      if(testIfNumber(input) == true) if(Integer.parseInt(input) <= 31) speed = Integer.parseInt(input);
      if(testIfNumber(input) == true) 
        if(Integer.parseInt(input) > 31) { 
              Random random = new Random(); red = random.nextInt(256); 
              green = random.nextInt(256);
              blue = random.nextInt(256); 
            }
  
      
    
  
      if(input.length() == 2 && testIfNumber(input) == false) if(input.equals("X2") == false) { dir2=input; if(nebunie == 5) nebunie = 0; nebunie++; }
      if(input.length() == 1 && testIfNumber(input) == false) if(input.equals("X") == false) { dir=input; if(nebunie == 5) nebunie = 0; nebunie++; }
    }
  }
  
  
}
  
   
