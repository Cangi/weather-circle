import processing.serial.*;

final int screenX=1000, screenY=700;
PImage background1, background2, p1Sprite, p2Sprite, brokenp11, brokenp12, brokenp21, brokenp22;
int p1X=200, p1Y=screenY - 260, p2X=screenX/2+200, p2Y=screenY - 260;
int bang1X, bang1Y, bang2X, bang2Y;
int player1Score=0, player2Score=0, player1HP=3, player2HP=3;
boolean player1SuperAttack = false, player2SuperAttack = false, shootSuper1 = false, shootSuper2 = false;
int[] enemy1X, enemy1Y, enemy2X, enemy2Y;
float[] scale1X, scale1Y, scale2X, scale2Y;
boolean shooting1=false, shooting2=false, spawning1=true, spawning2=true;
int newEnemyId1 = 0, newEnemyId2 = 0;
boolean[] falling1, falling2;
boolean isRunning = true;
int broken1lvl=0, broken2lvl=0;
int enemySpeed = 2, playerSpeed = 25, extraShootSpeed = 7;
int king1Scale, king2Scale;

Serial myPort;
int myPortNumber = 2; // CHANGE THIS FOR DIFFERENT PORTS FOR ARDUINO

void setup() {
  size(1000, 700);
  try {
    myPort = new Serial(this, Serial.list()[myPortNumber], 9600);
  }
  catch(Exception ex) {
    println("Wrong port");  
  }
  
  enemy1X = new int[10];
  enemy1Y = new int[10];
  enemy2X = new int[10];
  enemy2Y = new int[10];
  scale1X = new float[10];
  scale1Y = new float[10];
  scale2X = new float[10];
  scale2Y = new float[10];
  falling1 = new boolean[10];
  falling2 = new boolean[10];
  for(int i=0; i<enemy1X.length; i++)
  {
    enemy1X[i]=(int)random(30, screenX/2-30);
    enemy1Y[i]=0; // change
    enemy2X[i]=(int)random(screenX/2+30, screenX-10);
    enemy2Y[i]=0;
    scale1X[i]=10;
    scale1Y[i]=10;
    scale2X[i]=10;
    scale2Y[i]=10;
    falling1[i]=false;
    falling2[i]=false;
  }
  
  background1 = loadImage("sprites/background1.png");
  background2 = loadImage("sprites/background2.png");
  brokenp11 = loadImage("sprites/broken2.png");
  brokenp12 = loadImage("sprites/broken22.png");
  brokenp21 = loadImage("sprites/broken1.png");
  brokenp22 = loadImage("sprites/broken11.png");
  p1Sprite = loadImage("sprites/player1.png");
  p2Sprite = loadImage("sprites/player2.png");
  
  king1Scale = p1Sprite.height;
  king2Scale = p2Sprite.height;
  
  repaint();
}
void repaint()
{
  
  background(0);
  
  
  
  if(broken1lvl==1) {
    image(brokenp11, 0, 0);
  } else if(broken1lvl==2) {
    image(brokenp12, 0, 0);
  } else {
    image(background1, 0, 0);
  }
  if(broken2lvl==1) {
    image(brokenp21, screenX/2, 0);
  } else if(broken2lvl==2) {
    image(brokenp22, screenX/2, 0);
  } else {
    image(background2, screenX/2, 0);
  }
  
  p1Sprite.resize(king1Scale, king1Scale);
  image(p1Sprite, p1X, p1Y);
  p2Sprite.resize(king2Scale, king2Scale);
  image(p2Sprite, p2X, p2Y);
  fill(255,255,255);
  rect(screenX/2-10, 0, 20, screenY);
}
void draw() {
  
  if(isRunning) {
    repaint();
    
    if(shootSuper1) {
      fill(0);
      ellipse(bang1X+50,bang1Y, 15,15);
      bang1X+=extraShootSpeed;
      if(bang1X>screenX) {
        shootSuper1 = false;
        player1SuperAttack = false;
      }
    }
    if(spawning1) {
      falling1[newEnemyId1] = true;
      spawning1=false;
    }
    if(enemy1Y[newEnemyId1]>250) {
      spawning1 = true;
      for(int i=0; i<enemy1X.length; i++)
      {
        if(!falling1[i]) { // make sure that there's always someone spawning
          newEnemyId1 = i;
          break;
        }
      }
    }
    
    if(shootSuper2) {
      fill(0);
      ellipse(bang2X+50,bang2Y, 15,15);
      bang2X-=extraShootSpeed;
      if(bang2X<0) {
        shootSuper2 = false;
        player2SuperAttack = false;
      }
    }
    if(spawning2) {
      falling2[newEnemyId2] = true;
      spawning2=false;
    }
    if(enemy2Y[newEnemyId2]>250) {
      spawning2 = true;
      for(int i=0; i<enemy1X.length; i++)
      {
        if(!falling2[i]) { // make sure that there's always someone spawning
          newEnemyId2 = i;
          break;
        }
      }
    }
    
    for(int i=0; i<enemy1X.length; i++)
    {
      if(falling1[i]) {
        //println(enemy1Y);
        enemy1Y[i]+=enemySpeed;
        scale1X[i]+=(float)enemySpeed/10;
        scale1Y[i]+=(float)enemySpeed/10;
        fill(159,99,66);
        ellipse(enemy1X[i],enemy1Y[i], scale1X[i],scale1Y[i]);
      }
      if(falling2[i]) {
        //println(enemy1Y);
        enemy2Y[i]+=enemySpeed;
        scale2X[i]+=(float)enemySpeed/10;
        scale2Y[i]+=(float)enemySpeed/10;
        fill(159,99,66);
        ellipse(enemy2X[i],enemy2Y[i], scale2X[i],scale2Y[i]);
      }
      
      /* COLLISION DETECTION *********************************************************/
      if(bang1X>=enemy1X[i]-80 && bang1X<=enemy1X[i]-20 && bang1Y>=enemy1Y[i] && bang1Y<=enemy1Y[i]+20) {
        bang1Y=-50;
        player1Score++;
        if(player1Score%5==0) player1SuperAttack = true;
        enemy1Y[i]=0;
        scale1X[i]=10;
        scale1Y[i]=10;
        if(i==newEnemyId1) {
          spawning1 = true;
          for(int j=0; j<enemy1X.length; j++)
          {
            if(!falling1[j]) { // make sure that there's always someone spawning
              newEnemyId1 = j;
              break;
            }
          }
        }
        enemy1X[i]=(int)random(30, screenX/2-30);
        falling1[i]=false;
      }
      if(bang2X>=enemy2X[i]-80 && bang2X<=enemy2X[i]-20 && bang2Y>=enemy2Y[i] && bang2Y<=enemy2Y[i]+20) {
        bang2Y=-50;
        player2Score++;
        if(player2Score%5==0) player2SuperAttack = true;
        enemy2Y[i]=0;
        scale2X[i]=10;
        scale2Y[i]=10;
        if(i==newEnemyId2) {
          spawning2 = true;
          for(int j=0; j<enemy2X.length; j++)
          {
            if(!falling2[j]) { // make sure that there's always someone spawning
              newEnemyId2 = j;
              break;
            }
          }
        }
        enemy2X[i]=(int)random(screenX/2+30, screenX);
        falling2[i]=false;
      }
      
      if(bang1X<=p2X+20 && bang1X>=p2X-40 && bang1Y>=p2Y && bang1Y<=p2Y+50) {
        print("Player 1 shot Player 2, Player 1 WINS!");
        shootSuper1 = false;
        isRunning = false;
        fill(255,255,255);
        strokeWeight(5);
        rect(screenX/2-100, screenY/2-50, 200, 100);
        fill(0);
        textSize(18);
        text("Player 1 shot Player 2!",screenX/2-80,screenY/2+5);
      }
      if(bang2X<=p1X+20 && bang2X>=p1X-40 && bang2Y>=p1Y && bang2Y<=p1Y+50) {
        print("Player 2 shot Player 1, Player 2 WINS!");
        shootSuper2 = false;
        isRunning = false;
        fill(255,255,255);
          strokeWeight(5);
          rect(screenX/2-100, screenY/2-50, 200, 100);
          fill(0);
          textSize(18);
          text("Player 2 shot Player 1!",screenX/2-80,screenY/2+5);
  
      }
      /* COLLISION DETECTION *********************************************************/
      
      /* CASTLE CRASH DETECTION ****************************/
      if(enemy1Y[i]>=screenY-200) {
        enemy1Y[i]=0;
        scale1X[i]=10;
        scale1Y[i]=10;
        player1HP--;
        broken1lvl++;
        if(player1HP==0) {
          print("player 2 WINS!!!");
          isRunning = false;
          fill(255,255,255);
          strokeWeight(5);
          rect(screenX/2-100, screenY/2-50, 200, 100);
          fill(0);
          textSize(22);
          text("player 2 WINS!!!",screenX/2-80,screenY/2+5);
        }
        enemy1X[i]=(int)random(30, screenX/2-30);
        falling1[i]=false;
        

      }
      if(enemy2Y[i]>=screenY-200) {
        enemy2Y[i]=0;
        scale2X[i]=10;
        scale2Y[i]=10;
        player2HP--;
        broken2lvl++;
        if(player2HP==0) {
          print("player 1 WINS!!!");
          isRunning = false;
          fill(255,255,255);
          strokeWeight(5);
          rect(screenX/2-100, screenY/2-50, 200, 100);
          fill(0);
          textSize(22);
          text("player 1 WINS!!!",screenX/2-80,screenY/2+5);
        }
          
        enemy2X[i]=(int)random(screenX/2+30, screenX);
        falling2[i]=false;
        

      }
      
      
    }
    image(p1Sprite, p1X, p1Y);
    image(p2Sprite, p2X, p2Y);  
    
    
    if(shooting1) {
      fill(0);
      ellipse(bang1X+50,bang1Y, 15,15);
      bang1Y-=20;
      if(bang1Y<0) {
        shooting1 = false;
      }
    }
    if(shooting2) {
      fill(0);
      ellipse(bang2X+50,bang2Y, 15,15);
      bang2Y-=20;
      if(bang2Y<0) {
        shooting2 = false;
      }
    }
  
  }
  
  try {
  if(myPort.available() > 0) {
    String input = myPort.readStringUntil('\n');
    if(input!=null) {
      input=input.trim();
      println(input);
      if(input.equals("button11") && !shooting1 && !shootSuper1) {//PLAYER 1
        bang1X=p1X;
        bang1Y=p1Y;
        shooting1 = true;
      }
      if(input.equals("button12") && player1SuperAttack && !shootSuper1) {//PLAYER 1
        bang1X=p1X;
        bang1Y=p1Y+50;
        shootSuper1 = true;
      }
      if(input.equals("button21") && !shooting2 && !shootSuper2) { //PLAYER 2
        bang2X=p2X;
        bang2Y=p2Y;
        shooting2 = true;
      }
      if(input.equals("button22")  && player2SuperAttack && !shootSuper2) { //PLAYER 2
        bang2X=p2X;
        bang2Y=p2Y+50;
        shootSuper2 = true;
      }
      if(input.equals("u1") && p1Y>200) { //PLAYER 1
        p1Y-=playerSpeed;
        king1Scale-=3;
      }
      if(input.equals("r1") && p1X<screenX/2-100) {
        p1X+=playerSpeed;
      }
      if(input.equals("l1") && p1X>0) {
        p1X-=playerSpeed;
      }
      if(input.equals("d1") && p1Y<screenY-260) {
        p1Y+=playerSpeed;
        king1Scale+=3;
      }
      
      if(input.equals("u2") && p2Y>200) {// PLAYER 2
        p2Y-=playerSpeed;
        king2Scale-=3;
      }
      if(input.equals("r2") && p2X<screenX-80) {
        p2X+=playerSpeed;
      }
      if(input.equals("l2") && p2X>screenX/2) {
        p2X-=playerSpeed;
      }
      if(input.equals("d2") && p2Y<screenY-260) {
        p2Y+=playerSpeed;
        king2Scale+=3;
      }
    }
  } }
  catch(Exception ex) {
  }
}

void keyPressed()
{
  
  if(key=='v' && !shooting1 && !shootSuper1) {
    bang1X=p1X;
    bang1Y=p1Y;
    shooting1 = true;
  }
  if(key=='b' && player1SuperAttack && !shootSuper1) {
    bang1X=p1X;
    bang1Y=p1Y+50;
    shootSuper1 = true;
  }
  if(key=='.' && !shooting2 && !shootSuper2) {
    bang2X=p2X;
    bang2Y=p2Y;
    shooting2 = true;
  }
  if(key=='/' && player2SuperAttack && !shootSuper2) {
    bang2X=p2X;
    bang2Y=p2Y+50;
    shootSuper2 = true;
  }
  
  if(key=='w' && p1Y>screenY/2) {
    p1Y-=40;
  }
  if(key=='d' && p1X<screenX/2-100) {
    p1X+=40;
  }
  if(key=='a' && p1X>0) {
    p1X-=40;
  }
  if(key=='s' && p1Y<screenY-260) {
    p1Y+=40;
  }
  
  if(key=='i' && p2Y>screenY/2) {
    p2Y-=40;
  }
  if(key=='l' && p2X<screenX-80) {
    p2X+=40;
  }
  if(key=='j' && p2X>screenX/2) {
    p2X-=40;
  }
  if(key=='k' && p2Y<screenY-260) {
    p2Y+=40;
  }
}
