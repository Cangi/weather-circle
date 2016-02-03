import processing.serial.*;

Serial myPort;
String input;
int screenX = 800, screenY = 600;
final int pWidth=25, pHeight=150;
int p1Y=screenY/2-pHeight/2, p2Y=screenY/2-pHeight/2;

int speed = 25;
int ballX=screenX/2, ballY=screenY/2;
int bDirX=1, bDirY=0, bSpeed=5;
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
  ellipse(ballX,ballY,25, 25); //elipse
}

void draw()
{  
  
  /* COLLISION DETTECTION ***********/
  if(ballX<=pWidth && ballY>=p1Y && ballY<=p1Y+pHeight || ballX>=screenX-pWidth && ballY>=p2Y && ballY<=p2Y+pHeight) {
     if(bDirX>0) bDirX-=bDirX*2;
     else bDirX+=bDirX*(-2);
  }
  if(ballX<0 || ballX>screenX) ballX=screenX/2;
  
  
  ballX=ballX+bDirX*bSpeed;
  ballY=ballY+bDirY*bSpeed;
  
  repaint();
  
   if(myPort.available() > 0)
  {
    input = myPort.readStringUntil('\n').trim();
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

void keyPressed()
{
  
  if(key == 'w') p1Y-=speed;
  if(key == 's') p1Y+=speed;
  if(key == 'i') p2Y-=speed;
  if(key == 'k') p2Y+=speed;
}



