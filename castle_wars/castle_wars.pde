final int screenX=1000, screenY=700;
PImage background, p1Sprite, p2Sprite;
int p1X=200, p1Y=screenY - 260, p2X=screenX/2+200, p2Y=screenY - 260;
int bang1X, bang1Y, bang2X, bang2Y;
int player1Score=0, player2Score=0, player1HP=3, player2HP=3;
boolean player1SuperAttack = false, player2SuperAttack = false, shootSuper1 = false, shootSuper2 = false;
int[] enemy1X, enemy1Y, enemy2X, enemy2Y;
float[] scale1X, scale1Y, scale2X, scale2Y;
boolean shooting1=false, shooting2=false, spawning1=true, spawning2=true;
int newEnemyId1 = 0, newEnemyId2 = 0;
boolean[] falling1, falling2;
<<<<<<< HEAD
boolean isRunning = true;

=======
>>>>>>> dbb21f020d7d02e5f93a0ea8ffedfa853a89519c
void setup() {
  size(1000, 700);
  
  enemy1X = new int[10];
  enemy1Y = new int[10];
  enemy2X = new int[10];
  enemy2Y = new int[10];
<<<<<<< HEAD
  scale1X = new float[10];
  scale1Y = new float[10];
  scale2X = new float[10];
  scale2Y = new float[10];
  falling1 = new boolean[10];
  falling2 = new boolean[10];
=======
  
  falling1 = new boolean[10];
  falling2 = new boolean[10];
  
>>>>>>> dbb21f020d7d02e5f93a0ea8ffedfa853a89519c
  for(int i=0; i<enemy1X.length; i++)
  {
    enemy1X[i]=(int)random(30, screenX/2-30);
    enemy1Y[i]=0; // change
<<<<<<< HEAD
    enemy2X[i]=(int)random(screenX/2+30, screenX-10);
    enemy2Y[i]=0;
    scale1X[i]=10;
    scale1Y[i]=10;
    scale2X[i]=10;
    scale2Y[i]=10;
=======
    enemy2X[i]=(int)random(screenX/2, screenX-10);
    enemy2Y[i]=0;
>>>>>>> dbb21f020d7d02e5f93a0ea8ffedfa853a89519c
    falling1[i]=false;
    falling2[i]=false;
  }
  
  background = loadImage("sprites/background.jpg");
  p1Sprite = loadImage("sprites/player1.png");
  p2Sprite = loadImage("sprites/player2.png");
  repaint();
}
void repaint()
{
  
  background(0);
  image(background, 0, 0);
  image(p1Sprite, p1X, p1Y);
  image(p2Sprite, p2X, p2Y);
  fill(255,255,255);
  rect(screenX/2-10, 0, 20, screenY);
}
void draw() {
  
<<<<<<< HEAD
  if(isRunning) {
    repaint();
    
    if(shootSuper1) {
      fill(0);
      ellipse(bang1X+50,bang1Y, 15,15);
      bang1X+=20;
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
      bang2X-=20;
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
        enemy1Y[i]+=3;
        scale1X[i]+=0.3;
        scale1Y[i]+=0.3;
        fill(159,99,66);
        ellipse(enemy1X[i],enemy1Y[i], scale1X[i],scale1Y[i]);
      }
      if(falling2[i]) {
        //println(enemy1Y);
        enemy2Y[i]+=3;
        scale2X[i]+=0.3;
        scale2Y[i]+=0.3;
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
        rect(screenX/2-100, screenY/2-50, 200, 100);
        text("Player 1 shot Player 2, Player 1 WINS!",5,5);
      }
      if(bang2X<=p1X+20 && bang2X>=p1X-40 && bang2Y>=p1Y && bang2Y<=p1Y+50) {
        print("Player 2 shot Player 1, Player 2 WINS!");
        shootSuper2 = false;
        isRunning = false;
        rect(screenX/2-100, screenY/2-50, 200, 100);
        text("Player 1 shot Player 2, Player 1 WINS!",5,5);
=======
  repaint();
  
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
  for(int i=0; i<enemy1X.length; i++)
  {
    if(falling1[i]) {
      //println(enemy1Y);
      enemy1Y[i]+=3;
      fill(159,99,66);
      ellipse(enemy1X[i],enemy1Y[i], 50,50);
    }
    
    /* COLLISION DETECTION *********************************************************/
    if(bang1X>=enemy1X[i]-80 && bang1X<=enemy1X[i]-20 && bang1Y>=enemy1Y[i] && bang1Y<=enemy1Y[i]+20) {
      bang1Y=-50;
      enemy1Y[i]=0;
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
    /* COLLISION DETECTION *********************************************************/
    
    /* CASTLE CRASH DETECTION ****************************/
    if(enemy1Y[i]>=screenY-200) {
      enemy1Y[i]=0;
      enemy1X[i]=(int)random(30, screenX/2-30);
      falling1[i]=false;
    }
    
    
  }
  image(p1Sprite, p1X, p1Y);
  image(p2Sprite, p2X, p2Y);
  /* TESTING 
  enemyY+=5;
  fill(159,99,66);
  ellipse(enemyX,enemyY, 50,50);*/
  
  
>>>>>>> dbb21f020d7d02e5f93a0ea8ffedfa853a89519c
  
      }
      /* COLLISION DETECTION *********************************************************/
      
      /* CASTLE CRASH DETECTION ****************************/
      if(enemy1Y[i]>=screenY-200) {
        enemy1Y[i]=0;
        scale1X[i]=10;
        scale1Y[i]=10;
        player1HP--;
        if(player1HP==0) {
          print("player 2 WINS!!!");
          isRunning = false;
          rect(screenX/2-100, screenY/2-50, 200, 100);
        text("player 2 WINS!!!",5,5);
        }
        enemy1X[i]=(int)random(30, screenX/2-30);
        falling1[i]=false;
        

      }
      if(enemy2Y[i]>=screenY-200) {
        enemy2Y[i]=0;
        scale2X[i]=10;
        scale2Y[i]=10;
        player2HP--;
        if(player2HP==0) {
          print("player 1 WINS!!!");
          isRunning = false;
          rect(screenX/2-100, screenY/2-50, 200, 100);
          fill(0);
        text("player 1 WINS!!!",screenX/2,screenY/2);
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
}

void keyPressed()
{
<<<<<<< HEAD
  
  if(key=='v' && !shooting1 && !shootSuper1) {
=======
  if(key=='m') {
    for(int i = 0; i<10; i++)
    {
      println(falling1[i]);
      
    }
    println(spawning1);
  }
  
  if(key=='v') {
>>>>>>> dbb21f020d7d02e5f93a0ea8ffedfa853a89519c
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
<<<<<<< HEAD
  if(key=='s' && p1Y<screenY-260) {
=======
  if(key=='s' && p1Y<screenY-220) {
>>>>>>> dbb21f020d7d02e5f93a0ea8ffedfa853a89519c
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
