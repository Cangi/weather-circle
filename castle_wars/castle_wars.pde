final int screenX=1000, screenY=700;
PImage castle1, castle2, p1Sprite, p2Sprite;
int p1X=200, p1Y=screenY - 250, p2X=screenX/2+200, p2Y=screenY - 250;
int bang1X, bang1Y, bang2X, bang2Y;
int[] enemy1X, enemy1Y, enemy2X, enemy2Y;
boolean shooting1=false, shooting2=false, spawning1=true, spawning2=true;
void setup() {
  size(screenX, screenY);
  
  enemy1X = new int[10];
  enemy1Y = new int[10];
  enemy2X = new int[10];
  enemy2Y = new int[10];
  
  for(int i=0; i<enemy1X.length; i++)
  {
    enemy1X[i]=random(0, screenX/2);
    enemy1Y[i]=-500;
    enemy2X[i]=random(screenX/2, screenX);
    enemy2Y[i]=-500;
  }
  
  
  castle1 = loadImage("sprites/castle.png");
  castle2 = loadImage("sprites/castle.png");
  p1Sprite = loadImage("sprites/player1.png");
  p2Sprite = loadImage("sprites/player2.png");
  repaint();
}
void repaint()
{
  
  background(0);
  image(castle1, 0, screenY-200);
  image(castle2, screenX/2, screenY-200);
  image(p1Sprite, p1X, p1Y);
  image(p2Sprite, p2X, p2Y);
  fill(255,255,255);
  rect(screenX/2-10, 0, 20, screenY);
}
void draw() {
  
  repaint();
  
  if(spawning1) {
    
  }
  /* TESTING */
  enemyY+=5;
  fill(159,99,66);
  ellipse(enemyX,enemyY, 50,50);
  
  /* COLLISION DETECTION *********************************************************/
  if(bang1X>=enemyX-80 && bang1X<=enemyX-20 && bang1Y>=enemyY && bang1Y<=enemyY+20) {
    bang1Y=-50;
    enemyY=-50;
  }
  /* COLLISION DETECTION *********************************************************/
  
  
  if(shooting1) {
    fill(150, 183, 255);
    ellipse(bang1X+50,bang1Y, 25,25);
    bang1Y-=20;
    if(bang1Y<0) {
      shooting1 = false;
    }
  }
  if(shooting2) {
    fill(255, 196, 222);
    ellipse(bang2X+50,bang2Y, 25,25);
    bang2Y-=50;
    if(bang2Y<0) {
      shooting2 = false;
    }
  }
}

void keyPressed()
{
  if(key=='v') {
    bang1X=p1X;
    bang1Y=p1Y;
    shooting1 = true;
  }
  if(key=='/') {
    bang2X=p2X;
    bang2Y=p2Y;
    shooting2 = true;
  }
  
  if(key=='w' && p1Y>screenY/2) {
    p1Y-=10;
  }
  if(key=='d' && p1X<screenX/2-100) {
    p1X+=10;
  }
  if(key=='a' && p1X>0) {
    p1X-=10;
  }
  if(key=='s' && p1Y<screenY-220) {
    p1Y+=10;
  }
  
  if(key=='i' && p2Y>screenY/2) {
    p2Y-=10;
  }
  if(key=='l' && p2X<screenX-80) {
    p2X+=10;
  }
  if(key=='j' && p2X>screenX/2) {
    p2X-=10;
  }
  if(key=='k' && p2Y<screenY-220) {
    p2Y+=10;
  }
}
