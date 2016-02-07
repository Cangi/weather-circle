
final int screenX=800, screenY=600, Xcons=screenX/25;

int[][] board = new int[screenX/30][screenY/30];

char dir1='r', dir2='l';
int p1x=4, p1y=4;
void setup()
{
   size(screenX,screenY);
   background(204, 204 , 225);
   for(int i=0; i<board.length; i++)
   {
     for(int j=0; j<screenY/30; j++)
     {
       board[i][j] = 0;
     }
   }
   
   board[p1x-1][p1y]=1;
   board[p1x][p1y]=2;
}

void draw()
{
   board[p1x-1][p1y]=1;
   board[p1x][p1y]=2;
   for(int i=0; i<board.length; i++)
   {
     for(int j=0; j<screenY/30; j++)
     {
       if(board[i][j]==0) {
         fill(0);
         rect(i*Xcons, j*Xcons, Xcons, Xcons);
       } 
       if(board[i][j]==1) {
         fill(255,255,255);
         rect(i*Xcons, j*Xcons, Xcons, Xcons);
       }
       if(board[i][j]==2) {
         fill(220,220,220);
         rect(i*Xcons, j*Xcons, Xcons, Xcons);
       }
     }
   }
   if(dir1=='r') {
     board[p1x-1][p1y]=0;
     
     p1x++;
     delay(500);
   }
  
}
