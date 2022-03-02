import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
private final static int NUM_ROWS = 5; //final = can't change
private final static int NUM_COLS = 5;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

//TO DO: step 9 and make 10 red

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
    
    setMines();
}
public void setMines() //STEP NINE
{
    //your code
    int row = (int)(Math.random()*NUM_ROWS)+1;
    int col = (int)(Math.random()*NUM_COLS)+1;
    if(!mines.contains(buttons[row][col])){ //if mines doesn't contain random row+col, add it
      mines.add(buttons[row][col]);
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
    
    return false;
}
public void displayLosingMessage()
{
    //your code here
}
public void displayWinningMessage()
{
    //your code here
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
    if(isValid(row, col-1) == true && mines.contains(buttons[row-1][col-1]))
      numMines ++;
    if(isValid(row, col+1) == true && mines.contains(buttons[row-1][col+1]))
      numMines ++;
    if(isValid(row+1, col-1) == true && mines.contains(buttons[row+1][col-1]))
      numMines ++;
    if(isValid(row+1, col) == true && mines.contains(buttons[row+1][col]))
      numMines ++;
    if(isValid(row+1, col+1) == true && mines.contains(buttons[row][col+1]))
      numMines ++;
     
     
    //System.out.println(numMines);
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

    // called by manager
    public void mousePressed ()  //STEP 13
    {
        clicked = true;
        //your code here
        if(mouseButton == RIGHT){
          if(flagged == true)
            flagged = false;
          flagged = false;
          clicked = flagged;
        }
        else if(mines.contains(this))
          displayLosingMessage();
        else if(countMines(NUM_ROWS, NUM_COLS) > 0)
          setLabel(countMines(NUM_ROWS, NUM_COLS));\
            //call for valid unclicked neighboring buttons
        /*if(isValid(r, c-1) == true && blobs[r][c-1].isMarked() == true)
      blobs[r][c-1].mousePressed();
      */
        mousePressed();
          
          
        
    }
    public void draw () 
    {    
        if (flagged)
            fill(0);
        else if( clicked && mines.contains(this) ) 
        fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

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
