import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.serial.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class pong extends PApplet {



Serial myPort;
int myPortNumber; // CHANGE THIS FOR DIFFERENT PORTS FOR ARDUINO

String input;
int screenX = 800, screenY = 600;
final int pWidth=screenX/32, pHeight=screenY/4, bDim = screenX/32;
int p1Y=screenY/2-pHeight/2, p2Y=screenY/2-pHeight/2;

int speed = 27;
float ballX=screenX/2, ballY=screenY/2;
float bDirX=1, bDirY=0;

float bStartSpeed=3.5f;
float bSpeed=bStartSpeed;

float MAXBOUNCEANGLE = PI/4;

int p1Score = 0, p2Score = 0;
boolean gameStarted = false;
public void setup()
{
  
  
  
  boolean ok = false;
  myPortNumber = -1; 
  while(ok == false) {
    try {
      print(myPortNumber + " ");
      myPort = new Serial(this, Serial.list()[myPortNumber], 9600); 
      myPort.available();
      ok = true;
      println(true);
    }
    catch(Exception ex) {
      myPortNumber++;
      if(myPortNumber >= 20) { 
        ok = true;
        speed += 20;
        println("no port found false");
      }
    }
  }
  
}

public void repaint()
{
  background(0);
  

  for(int i=0; i<15; i++)
  {
    rect(screenX/2-bDim/6.2485f, i*screenY/14.742014742f, screenX/70, screenY/20);
  }
  
  rect(-1, p1Y, pWidth, pHeight); // player 1
  rect(screenX-pWidth, p2Y, pWidth, pHeight); // player 2
  ellipse(ballX,ballY,bDim, bDim); //elipse
  
  textSize((screenX+screenY)/20);
  fill(255, 255, 255);
  text(p1Score, screenX/4, screenY/7);
  text(p2Score, 3*screenX/4-(screenX)/20, screenY/7);
  
}

public void draw()
{  
  if(!gameStarted) {
    ballX=screenX/2;
    ballY=screenY/2;
  }
  
  /* COLLISION DETTECTION FOR PADDLE***********/ 
  if(ballX+bSpeed<=pWidth && ballY>=p1Y && ballY<=p1Y+pHeight || ballX+bSpeed>=screenX-pWidth && ballY>=p2Y && ballY<=p2Y+pHeight) {
     
       /***********************PHYSICS****************************/ 
      float relativeIntersectY;
      if(ballX>screenX/2) relativeIntersectY = (p2Y+(pHeight/2)) - ballY;
      else relativeIntersectY = (p1Y+(pHeight/2)) - ballY;
      float normalizedRelativeIntersectionY = (relativeIntersectY/(pHeight/2));
      float bounceAngle = normalizedRelativeIntersectionY * MAXBOUNCEANGLE;
      if(ballX>screenX/2) bDirX = -bSpeed*cos(bounceAngle);
      else bDirX = bSpeed*cos(bounceAngle);
      bDirY = bSpeed*-sin(bounceAngle);
     
  }
  /* COLLISION DETTECTION FOR TOP and BOTTOM***********/ 
  if( ballY<=2 || ballY>=screenY) {
     println("K");
       /***********************PHYSICS****************************/ 
      //float relativeIntersectY;
      
      //float normalizedRelativeIntersectionY = (relativeIntersectY/(pHeight/2));
      float bounceAngle = 1 * MAXBOUNCEANGLE;
      if(bDirX>0) bDirX = bSpeed*cos(bounceAngle);
      else bDirX = -bSpeed*cos(bounceAngle);
      
      if(ballY>screenY/2) bDirY = bSpeed*-sin(bounceAngle);
      else bDirY = bSpeed*sin(bounceAngle);
     
  }
  if(ballX<0 || ballX>screenX) //WHEN GAME OVER
  {
    p1Y=screenY/2-pHeight/2;
    p2Y=screenY/2-pHeight/2;
    if(ballX<0) p2Score++;
    else if(ballX>screenX) p1Score++;
    ballX=screenX/2; 
    bSpeed=bStartSpeed;
    if(bDirX>0) bDirX=-1;
    else if(bDirX<0) bDirX=1;
    bDirY=0;
    gameStarted = false;
  }
  
  
  ballX=ballX+bDirX*bSpeed;
  ballY=ballY+bDirY*bSpeed;
  
  repaint();
  
  try{if(myPort.available() > 0)
  {
    input = myPort.readStringUntil('\n');
    if(input!=null) {
      input=input.trim().toUpperCase();
      println(input);
      
      if(input.equals("U1"))
      {
        gameStarted = true;
        if(p1Y>=5)
        p1Y-=speed;
      }
      if(input.equals("D1"))
      {
        gameStarted = true;
        if(p1Y<=screenY-pHeight)
        p1Y+=speed;
      }
      if(input.equals("U2"))
      {
        gameStarted = true;
        if(p2Y>=5)
        p2Y-=speed;
      }
      if(input.equals("D2"))
      {
        gameStarted = true;
        if(p2Y<=screenY-pHeight)
        p2Y+=speed;
      }
    }
  }   }
  catch (Exception ex) {
  }
}

public void keyPressed()
{
  gameStarted=true;
  if(key == 'w') if(p1Y>=5)
        p1Y-=speed;
  if(key == 's') if(p1Y<=screenY-pHeight)
        p1Y+=speed;
  if(key == 'i') if(p2Y>=5)
        p2Y-=speed;
  if(key == 'k') if(p2Y<=screenY-pHeight)
        p2Y+=speed;
}
  public void settings() {  size(800, 600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "pong" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
