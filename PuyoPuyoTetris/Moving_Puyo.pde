public class Puyo{
    //I might include a position of the spawned piece, but not currently sure.
    private int px = 2;
    private int py = 1;
    private int rotation = 0;
    
    private int[] positions = new int[4]; //saves current position
    private int[] check = new int[4];     //saves the possible values
    private int[][] board;                //to check if current values are possible
    private int[] puyos = new int[2];
    
    //This is the external parts of a piece in default state 
    // *     all pieces have 0,0 so it is not marked.
    // *X* is the j piece. 
                                    
    public int[]placements = {0,-1,1,0,0,1,-1,0};
    
    public int[][]SRS = Constants.puyoKick;//sets it to default SRS
    
    public Puyo(int p, int[][]board){
      
      this.board = board;  //initialize board;

      puyos[0] = p/5+1;
      puyos[1] = p%5+1;
      
      //initialize positions
      positions[0] = px;
      positions[1] = py;
      positions[2] = px;
      positions[3] = py-1;
      
    }

    public int[] getPiece(){
      //return color1*5+color2;
      return puyos;
    }
    
    
    public void setPosition(int x, int y){
          
    int[]temp = positions;  //makes position from check
    positions = check;      //and gives check a garbage array
    check = temp;
        
    px+=x;                  //set new px
    py+=y;                  //new py
      
    }
    
    
    
    public boolean checkNext(int x, int y) {

      check[0] = px + x;
      check[1] = py + y;
      
      boolean swap = check[0] >= 0 && check[0] < 6 && check[1] <14 &&
                     board[check[0]][check[1]]==0;      
      
      if (swap){
        
        check[2]   = positions[2]+ x;    //x
        check[3]   = positions[3]+ y;    //y
        
        swap = (check[2] >= 0 && check[2] < 6 && check[3] <14 && //check its on the board
                board[check[2]][check[3]]==0);  //check it doesn't overlap anything on board
                
      }
      
      return swap;
    }
    
    
    public int[] getPosition(){
      
      return positions;
    
    }    
    
    
    public void setRotate(boolean clockwise) {
         int[]temp = positions;  //makes position from check
         positions = check;      //and gives check a garbage array
         check = temp;
         
         if(clockwise){
           rotation = (rotation + 1) & 3;
         }
         else{
           rotation = (rotation + 3) & 3;
         }
         
         px = positions[0];
         py = positions[1];
    }
    
    
    public boolean checkClockwise(int kick) {//Default clockwise
      int temp = (rotation+1)&3;
      
      check[0] = px + SRS[rotation][2*kick];
      check[1] = py - SRS[rotation][2*kick+1];      
      
      boolean swap = check[0] >= 0 && check[0] < 6 && check[1] <14 && check[1] >=0 &&//check its on the board
                     board[check[0]][check[1]]==0;
      
      if (swap){
      check[2] = check[0] + placements[2*temp];
      check[3] = check[1] + placements[2*temp+1];      
      
      swap = check[2] >= 0 && check[2] < 6 && check[3] <14 && check[3] >=0 &&//check its on the board
                     board[check[2]][check[3]]==0;      
      }
      
      return swap;
    }
    
    public boolean checkCClockwise(int kick) {//Counterclockwise 
      int temp = (rotation+3)&3;
      
      check[0] = px - SRS[rotation][2*kick];
      check[1] = py + SRS[rotation][2*kick+1];      
      
      boolean swap = check[0] >= 0 && check[0] < 6 && check[1] <14 && check[1] >=0 &&//check its on the board
                     board[check[0]][check[1]]==0;
      
      if (swap){
      check[2] = check[0] + placements[2*temp];
      check[3] = check[1] + placements[2*temp+1];      
      
      swap = check[2] >= 0 && check[2] < 6 && check[3] <14 && check[3] >=0 &&//check its on the board
                     board[check[2]][check[3]]==0;      
      }
      
      return swap;
    } 
     
}
