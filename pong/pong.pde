import processing.serial.*;

Serial myPort;
String input;
int screenX = 800, screenY = 600;
final int pWidth=screenX/32, pHeight=screenY/4, bDim = screenX/32;
int p1Y=screenY/2-pHeight/2, p2Y=screenY/2-pHeight/2;

int speed = 50;
float ballX=screenX/2, ballY=screenY/2;
float bDirX=1, bDirY=0;
int bSpeed=3;

float MAXBOUNCEANGLE = PI/4;

void setup()
{
  size(screenX, screenY);
  myPort = new Serial(this, Serial.list()[0], 9600);
  background(0);
}

void repaint()
{
  background(0);
  rect(-1, p1Y, pWidth, pHeight); // player 1
  rect(screenX-pWidth, p2Y, pWidth, pHeight); // player 2
  ellipse(ballX,ballY,bDim, bDim); //elipse
}

void draw()
{  
  
  /* COLLISION DETTECTION FOR PADDLE***********/ 
  if(ballX<=pWidth && ballY>=p1Y && ballY<=p1Y+pHeight || ballX>=screenX-pWidth && ballY>=p2Y && ballY<=p2Y+pHeight) {
     
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
    ballX=screenX/2; 
    bSpeed=3;
    if(bDirX>0) bDirX=-1;
    else if(bDirX<0) bDirX=1;
    bDirY=0;
  }
  
  
  ballX=ballX+bDirX*bSpeed;
  ballY=ballY+bDirY*bSpeed;
  
  repaint();
  
   if(myPort.available() > 0)
  {
    
    input = myPort.readStringUntil('\n');
    if(input!=null) {
      input=input.trim();
      println(input);
      if(input.equals("U1"))
      {
        p1Y-=speed;
      }
      if(input.equals("D1"))
      {
        p1Y+=speed;
      }
      if(input.equals("U2"))
      {
        p2Y-=speed;
      }
      if(input.equals("D2"))
      {
        p2Y+=speed;
      }
    }
  }   
}

void keyPressed()
{
  
  if(key == 'w') p1Y-=speed;
  if(key == 's') p1Y+=speed;
  if(key == 'i') p2Y-=speed;
  if(key == 'k') p2Y+=speed;
}



