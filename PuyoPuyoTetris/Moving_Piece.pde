public class Piece{
    //I might include a position of the spawned piece, but not currently sure.
    private int px = 4;
    private int py = 1;
    private int piece;
    private int rotation = 0;
    
    private int shadowPiece = 0;
    
    private int[] positions = new int[8]; //saves current position
    private int[] check = new int[8];     //saves the possible values
    private int[][] board;                //to check if current values are possible
    
    
    //This is the external parts of a piece in default state 
    // *     all pieces have 0,0 so it is not marked.
    // *X* is the j piece. 
    private int[] placements =     { 0,0,  0, 0,  0, 0, //nothing
                                    -1,0,  1, 0,  2, 0, //I
                                    -1,0,  1, 0, -1,-1, //J
                                    -1,0,  1, 0,  1,-1, //L
                                    -1,0,  0,-1,  1,-1, //S
                                     1,0,  0,-1, -1,-1, //Z
                                     1,0,  0,-1,  1,-1, //O
                                    -1,0,  0,-1,  1, 0  //T
                                    };
    
   public Piece(int p, int[][]board){
      
      this.board = board;  //initialize board;

      piece = p;
      
      //initialize positions
      positions[0] = px;
      positions[1] = py;
      for(int i = 0; i<6; i+=2){
        positions[i+2] = positions[0]+ placements[6*piece + i];    
        positions[i+3] = positions[1]+ placements[6*piece + i +1];
      }
      
      //intialize shadow piece
      while(checkNext(0, shadowPiece+1)){
        ++shadowPiece;
      }
      
    }

    public int getPiece(){
      return piece;
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
      
      boolean swap = check[0] >= 0 && check[0] < 10 && check[1] <20 &&
                     board[check[0]][check[1]]==0;      
      
      for(int i = 0; i<6 && swap; i+=2){
        
        check[i+2] = check[0]+ placements[6*piece + i];    //x
        check[i+3] = check[1]+ placements[6*piece + i +1]; //y
        
        swap = (check[i+2] >= 0 && check[i+2] < 10 && check[i+3] <20 && //check its on the board
                board[check[i+2]][check[i+3]]==0);  //check it doesn't overlap anything on board
                
      }
      return swap;
    }
    
    public int[] getPosition(){
      
      return positions;
    
    }
    
    //returns height from Shadow Piece
    public int shadowPiece(int x, int y) {
      if (x == 0){
        shadowPiece -= y;
      }
      else{
        shadowPiece = 0;
        while(checkNext(0,shadowPiece+1)){
          ++shadowPiece;
        }
      }
      
      return shadowPiece;
      
    }
    
    
     
}
