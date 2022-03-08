import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
private final static int NUM_ROWS = 10; //final = can't change
private final static int NUM_COLS = 10;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined
public int numOfMines = 0;
public int[] myColors = {#9effa5, #77bd7c}; 
void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int r = 0; r<NUM_ROWS; r++){
      for(int c = 0; c< NUM_COLS; c++){
        buttons[r][c] = new MSButton(r, c);
      }
    }
    
    for(int i = 0; i<NUM_COLS/2; i++)
      setMines();
}
public void setMines() //STEP NINE
{
    //your code
    int row = (int)(Math.random()*NUM_ROWS);
    int col = (int)(Math.random()*NUM_COLS);
    if(!mines.contains(buttons[row][col])){ 
      mines.add(buttons[row][col]);
      numOfMines += 1;
    }
}

public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    //if all flagged are mines
    int flaggedCount = 0;
    for(int i = 0; i<numOfMines; i++){
      if(mines.get(i).isFlagged() == true)
        flaggedCount ++;
    }
    if(flaggedCount == numOfMines){
      displayWinningMessage();
      return true;
    }
    return false;
}
public void displayLosingMessage()
{
    //your code here
    
    textSize(100/NUM_ROWS);
    if(mines.contains(this))
      fill(255);
     /*
    for(int i = 0; i<numOfMines; i++){
      mines.get(i).fill(255); 
    }
    */
    
    for(int r = 0; r<NUM_ROWS; r++){
      for(int c = 0; c<NUM_COLS; c++){
        buttons[r][c].setLabel("lose");
      }
    }
    //display positions of bombs
}
public void displayWinningMessage()
{
    //your code here
    //text that says you won
    textSize(100/NUM_ROWS);
    
    for(int r = 0; r<NUM_ROWS; r++){
      for(int c = 0; c<NUM_COLS; c++){
        buttons[r][c].setLabel("win");
      }
    }
    
}
public boolean isValid(int r, int c)
{
    //your code here
    if(r>=0 && r<NUM_ROWS && c>=0 && c<NUM_COLS)
      return true;
    return false;
}
public int countMines(int row, int col)
{
    int numMines = 0;
    
    //your code here - count bombs in 8 neighbors, but 1st check if neighboring button
    //is valid before checking to see if it's a mine
    if(isValid(row-1, col-1) == true && mines.contains(buttons[row-1][col-1]))
      numMines ++;
    if(isValid(row-1, col) == true && mines.contains(buttons[row-1][col]))
      numMines ++;
    if(isValid(row-1, col+1) == true && mines.contains(buttons[row-1][col+1]))
      numMines ++;
    if(isValid(row, col-1) == true && mines.contains(buttons[row][col-1]))
      numMines ++;
    if(isValid(row, col+1) == true && mines.contains(buttons[row][col+1]))
      numMines ++;
    if(isValid(row+1, col-1) == true && mines.contains(buttons[row+1][col-1]))
      numMines ++;
    if(isValid(row+1, col) == true && mines.contains(buttons[row+1][col]))
      numMines ++;
    if(isValid(row+1, col+1) == true && mines.contains(buttons[row+1][col+1]))
      numMines ++;

    return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public int getr(){
      return myRow;
    }

    // called by manager
    public void mousePressed ()  //STEP 13
    {
        clicked = true;
        //your code here
        if(mouseButton == RIGHT){
          if(flagged == true){
            flagged = false;
            clicked = false;
          }
          else{
          flagged = true;
          //setLabel(".");
          fill(myColors[1]);
          }
        }
        else if(mines.contains(this)){
          displayLosingMessage();
          fill(#e7b3ff);  //color for unclicked mines
          
        }
        else if(countMines(myRow, myCol) > 0)  
          setLabel(countMines(myRow, myCol));

        else{
          if(isValid(myRow, myCol-1) == true && buttons[myRow][myCol-1].isFlagged() == true)
            buttons[myRow][myCol-1].mousePressed();
        
        }
        
    }
    public void draw () 
    {    
        if (flagged){
            fill(#ffbad1);
            setLabel("F");
        }
        else if( clicked && mines.contains(this) ) 
          fill(255,0,0);
        else if(clicked)
            fill( #a3f0ed );
        else{
          for(int r = 0; r<NUM_ROWS; r++)
            for(int c = 0; c<NUM_COLS; c++)
              if(buttons[r][c].getr() %2 == 0)
                fill(myColors[0]);
            fill(myColors[1]);
        }
            //fill( 100 );
        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}
