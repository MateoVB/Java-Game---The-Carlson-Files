//Author: Mateo Velarde
//Date: 5-20-18
//Purpose: AP Computer Science Final Project
 
 import ddf.minim.*;  //imports to use sound
 import ddf.minim.analysis.*;
 import ddf.minim.effects.*;
 import ddf.minim.signals.*;
 import ddf.minim.spi.*;
 import ddf.minim.ugens.*;

 import processing.sound.*;
 //SoundFile winningMusic, winningScreen;
 Minim minim;
 AudioPlayer winningMusic, winningScreen;
 AudioPlayer gameOver, wrongAnswer;
 PImage img, img2, img3, wonImage, lostImage, credits, decisionImage;
 int gameScreen = 0;
 Player user;
 private int points, whichThief;
 ArrayList<Teacher> listOfTeachers = new ArrayList<Teacher>();
 ArrayList<Clues> listOfClues = new ArrayList<Clues>();
 
 public void setup()  // SETUP METHOD : this is like main(string[]args)
 {
   size(800,800);
   //winningMusic = new SoundFile(this, "winnerMusic2.mp3");
   // winningMusic.play();
   //winningScreen = new SoundFile(this, "winningMusicScreen.mp3");
   minim = new Minim(this);
   winningMusic = minim.loadFile("winnerMusic2.mp3");
   winningMusic.play();
   winningScreen = minim.loadFile("winningMusicScreen.mp3"); 
   gameOver = minim.loadFile("mix.mp3");
   wrongAnswer = minim.loadFile("wrongAnswer.mp3");
   img = loadImage("gameIntro.jpg");
   img2 = loadImage("schoolFloor.jpg");
   img3 = loadImage("stormyNight.jpg");
   wonImage = loadImage("ThankYou.gif");
   lostImage = loadImage("lostScreen.jpg");
   credits = loadImage("credits.jpg");
   decisionImage = loadImage("decisionTime.jpg");
   user = new Player();
   points = 5;
   whichThief = (int)((Math.random()*3)+1);
   listOfTeachers.clear();
   listOfClues.clear();
   for(int i = 0; i <10; i++)
   {
     listOfTeachers.add(new Teacher());
   }
   for(int i = 0; i < 10; i++)
   {
     listOfClues.add(new Clues());
   }
 }
 public void draw()  // DRAW METHOD : this is like main(string[]args)
 {
    if (gameScreen == 0) {
    initScreen();
    }
    else if(gameScreen == 1){
      easyIntroScreen();
    }
    else if (gameScreen == 2){
      hardIntroScreen();
    }
    else if (gameScreen == 3) {
      gameScreen();
    }
    else if (gameScreen == 4) {
      hardScreen(); 
    } 
    else if (gameScreen == 5) {
    lostScreen();
    }
    else if (gameScreen == 6) {
    wonScreen();
    }
    else if (gameScreen == 7) {
    creditsScreen();
    }
    else if(gameScreen == 8)
    {
      decisionScreen();
    }
}
public void decisionScreen() {      
  background(decisionImage);
  if(whichThief == 1){
    fill(0);
    textSize(26); 
    text("Congratulations on finding all the clues! Now it is time", 40, 70);
    text("to decide who stole Mrs.Carlson's files! The clues reveal", 40, 110);
    text("that the thief usually wears a striped shirt! Press the", 40, 150);
    text("letter of the person you think is the thief! You can guess", 40, 190);
    text("who the thief is as many times as you can!", 40, 230);
    if (keyPressed) 
    {
      if (key == 'a' || key == 'A'){ winningScreen.play(); gameScreen = 6;}
    } 
    if (keyPressed) 
    {
      if (key == 'b' || key == 'B'){ playWrong(); }
    } 
    if (keyPressed) 
    {
      if (key == 'c' || key == 'C'){ playWrong();}
    } 
  }
  if(whichThief == 2){
    fill(0);
    textSize(26); 
    text("Congratulations on finding all the clues! Now it is time", 40, 70);
    text("to decide who stole Mrs.Carlson's files! The clues reveal", 40, 110);
    text("that the thief uses glasses and has a strong affection to", 40, 150);
    text("purple shirts! Press the letter of the person you think is", 40, 190);
    text("the thief! You can guess who the thief is as many times as", 40, 230);
    text("you can!", 40, 270);
    if (keyPressed) 
    {
      if (key == 'a' || key == 'A'){ playWrong();}
      if (key == 'b' || key == 'B'){ winningScreen.play(); gameScreen = 6;}
      if (key == 'c' || key == 'C'){ playWrong();}
    } 
  }
  if(whichThief == 3){
    fill(0);
    textSize(26); 
    text("Congratulations on finding all the clues! Now it is time", 40, 70);
    text("to decide who stole Mrs.Carlson's files! The clues reveal", 40, 110);
    text("that the thief was eating bread when he stole the files!", 40, 150);
    text("Press the letter of the person you think is the thief! You", 40, 190);
    text("can guess who the thief is as many times as you can!", 40, 230);
    if (keyPressed) 
    {
      if (key == 'a' || key == 'A'){ playWrong(); }
      if (key == 'b' || key == 'B'){ playWrong(); }
      if (key == 'c' || key == 'C'){ winningScreen.play(); gameScreen = 6;}
    } 
  }
}
public void playWrong()
{
  wrongAnswer.play();
  wrongAnswer.rewind();
}
void initScreen() {       //Initial Screen : 
  background(img);
  if (keyPressed) 
  {
    if (key == 'f' || key == 'F'){ gameScreen = 1;}
    if (key == 'h' || key == 'H'){ gameScreen = 2;}
    if (key == 'c' || key == 'C'){ gameScreen = 7;}
  } 
}
void creditsScreen()      //CREDITS SCREEN
{
  background(credits);
}
void easyIntroScreen() {    //INTRO SCREEN 
  background(img3);
}
void hardIntroScreen() {      //INTRO SCREEN
  background(img3);
}
void gameScreen() {        //EASY GAME SCREEN
  background(img2);
  user.update();           // calls player methods
  user.display();
  fill(255);
  textSize(26); 
  text("Reach 10 points to win!!                             TOTAL POINTS: " + points, 10, 30);  //Top of game screen
  for(int i = 0; i < 5; i++){
    listOfTeachers.get(i).update();
    listOfTeachers.get(i).display();
    if(listOfTeachers.get(i).lookForPlayer()){
      listOfTeachers.remove(i);
      listOfTeachers.add(new Teacher());
    }
  }
  for(int i = 0; i < listOfClues.size(); i++){
    if(listOfClues.get(i) != null){
    listOfClues.get(i).display();
    }
  }
  if (points <0) {                // ends game if points are negative
    gameScreen = 5;
  }
  if(listOfClues.size() == 0){       // ends game when there are no more clues 
    gameScreen = 5;
  }
  if(points >= 10){              //wins game if there are more than 10 points
    gameScreen = 8;
  }
}
public void hardScreen() {        //HARD GAME SCREEN
  background(img2);
  user.update();                 // calls player methods
  user.display();
  fill(255);
  textSize(26); //26
  text("Reach 15 points,without losing any,to win!   TOTAL POINTS: " + points, 5, 30); //TOP OF GAME SCREEN
  for(int i = 0; i < 10; i++)   // loop to call and display teachers
  {
    listOfTeachers.get(i).update();
    listOfTeachers.get(i).display();
    if(listOfTeachers.get(i).lookForPlayer())
    {
      listOfTeachers.remove(i);
      listOfTeachers.add(new Teacher());
    }
  }
  for(int i = 0; i < listOfClues.size(); i++)      //loop that calls and displays clues
  {
    if(listOfClues.get(i) != null)
    {
    listOfClues.get(i).display();
    }
  }
  if (points <0)                //ends game if negative points
  {
    gameScreen = 5;
  }
  if(listOfClues.size() == 0)      //ends game if no more clues left
  {
    gameScreen = 5;
  }
  if(points >= 15)               //wins game if more than 15 points have been collected
  {
    gameScreen = 8;
  }
}
void lostScreen() {           //losing screen
  winningMusic.pause();  //stop
  gameOver.play();
  background(lostImage);

}
void wonScreen() {                 //winning screen
  winningMusic.pause();   //stop
  background(wonImage);

}
public void mousePressed() {            //checks if mouse is pressed; changes screen
  // if we are on the initial screen when clicked, start the game
  if (gameScreen==1) {
    gameScreen = 3;
  }
  if (gameScreen==2){
    gameScreen = 4;
  }
  if (gameScreen==6){
    setup();
    gameScreen = 0;
  }
  if(gameScreen==5)
  {
    setup();
    gameScreen = 0;
  }
  if(gameScreen ==7)
  {
    gameScreen = 0;
  }
}
void startGame() {     //changes screen to 1
  gameScreen=1;
}
 public class Player extends UpperClass            //Player class
 {
   private int x, y;
   public int playerWidth = 55;
   public int playerHeight = 100;
   private PImage playerone;
   public Player()                    //constructer
   {
     x = 0;
     y = 50;
    playerone = loadImage("Teacher.gif");
   }  
   public void display()         //display method
   {
     image(playerone, x, y);
     update();
     lookForClues(); 
   }  
   public void update()     //update method when the player uses the arrow keys; cannot go out of the game's borders
   {
     if (keyPressed) 
     {
        if (keyCode == LEFT)
        {
          playerone = loadImage("TeacherLeft.gif");
          if(x>=0){
            x-=2;
          }
        }
        if (keyCode == RIGHT)
        {
          playerone = loadImage("Teacher.gif");
          if(x<=740){
            x+=2;
          }
        }
        if (keyCode == UP)
        {
          if(y>=0){
            y-=2;
          }
        }
        if (keyCode == DOWN)
        {
          if(y<=670) {
            y+=2;
          }
        }
     }
   }  
   public void lookForClues()    //checks if the player is touching any clues
    {
      int i = 0;
      while(i < listOfClues.size())
      {
        if(this.getLeftX()>listOfClues.get(i).getLeftX()&&this.getLeftX()<listOfClues.get(i).getRightX()&&this.getUpY()>listOfClues.get(i).getUpY()&&this.getUpY()< listOfClues.get(i).getDownY() || this.getRightX()<listOfClues.get(i).getRightX()&&this.getRightX()>listOfClues.get(i).getLeftX()&&this.getUpY()>listOfClues.get(i).getUpY()&&this.getUpY()<listOfClues.get(i).getDownY()||this.getLeftX()>listOfClues.get(i).getLeftX()&&this.getLeftX()<listOfClues.get(i).getRightX()&&this.getDownY()>listOfClues.get(i).getUpY()&&this.getDownY()<listOfClues.get(i).getDownY() || this.getRightX()>listOfClues.get(i).getLeftX()&&this.getRightX()<listOfClues.get(i).getRightX()&&this.getDownY()>listOfClues.get(i).getUpY()&&this.getDownY()<listOfClues.get(i).getDownY() || this.getMidX()>listOfClues.get(i).getLeftX()&&this.getMidX()<listOfClues.get(i).getRightX()&&this.getMidY()>listOfClues.get(i).getUpY()&&this.getMidY()<listOfClues.get(i).getDownY()) 
        {
            listOfClues.remove(i);
            //playSound("slurp.wav");  
            points++;
        }
        else
          i++;
      }        
    }
    public int getLeftX(){ return x;}
    public int getRightX(){ return x + playerWidth;}
    public int getUpY(){ return y;}
    public int getDownY(){ return y + playerHeight;}
    public int getMidX() { return x + playerWidth/2;}
    public int getMidY() { return y + playerHeight/2;}  
 }
 public class Teacher extends UpperClass   //teacher class, get called multiple times based on game mode chosen
 {
   private double x, y;
   private PImage teacher;
   private int teacherWidth = 50;
   private int teacherHeight = 90;
   private int whatTeacher;
   private int num = (int)(Math.random()*1001);
   public Teacher()  //constructer
   {
     x = (Math.random()*801);
     y = (Math.random()*750);
     whatTeacher = (int)(Math.random()*2);
     if(whatTeacher == 0)
       teacher = loadImage("Teacher1.gif");
     else
       teacher = loadImage("Teacher2.gif");
   }  
   public void display()     //displays the teacher on the screen
   {
     image(teacher, (int)x, (int)(y));
     update();
   }  
   public void update()     //updates the teacher, moves in a constant direction
   {
     if(num < 250) 
            x-=0.5;
     else if(num < 500)  
     {
       if(whatTeacher == 0){teacher = loadImage("Teacher1Right.gif"); } //changes picture of teacher according to her/his direction
       else {teacher = loadImage("Teacher2Right.gif"); }
       x+=0.5;
     }
     else if(num < 750)     
            y-=0.5;
     else if(num < 1001)      
            y+=0.5;
     if (x > width - 2) x = 0;
     if (x < -3) x = width-2;
     if (y > height) y = -2;
     if (y < -2) y = height;
    
   }
   public boolean lookForPlayer()   //checks if teacher touches the player, if so, then points will be deducted
    {
        if(this.getLeftX() > user.getLeftX() && this.getLeftX()< user.getRightX() && this.getUpY() > user.getUpY() && this.getUpY()< user.getDownY() || this.getRightX() < user.getRightX() && this.getRightX() > user.getLeftX() && this.getUpY()>user.getUpY() && this.getUpY() < user.getDownY() || this.getLeftX()>user.getLeftX()&&this.getLeftX()<user.getRightX()&&this.getDownY()>user.getUpY()&&this.getDownY()<user.getDownY() || this.getRightX()>user.getLeftX()&&this.getRightX()<user.getRightX()&&this.getDownY()>user.getUpY()&&this.getDownY()<user.getDownY() || this.getMidX()>user.getLeftX()&&this.getMidX()<user.getRightX()&&this.getMidY()>user.getUpY()&&this.getMidY()<user.getDownY())
        {
            points--;  //deducts points
            return true;
        }    
        return false;
    }
   public int getLeftX(){ return (int)x;}
   public int getRightX(){ return (int)x + teacherWidth;}
   public int getUpY(){ return (int)y;}
   public int getDownY(){ return (int)y + teacherHeight;}
   public int getMidX() { return (int)x + teacherWidth/2;}
   public int getMidY() { return (int)y + teacherHeight/2;}  
 }
 public class Clues implements ShowClass    //clues class
 {
   private int x, y;
   public int cluesWidth = 69;
   public int cluesHeight = 69;
   private PImage token;
   public Clues()   //constructer
   {
     x = (int)(Math.random()*750);
     y = (int)((Math.random()*720)+30);
     token = loadImage("clue.jpg");
   }
   public Clues(int x, int y)    //can make the clue appear where you want it to in the game
   {
     this.x = x;
     this.y = y;
     token = loadImage("clue.jpg");
   }
   public void display()      //displays the clue somewhere in the gamescreen
   {
     image(token, (int)x, (int)(y));
   }  
   public int getLeftX(){ return x;}
   public int getRightX() { return x + cluesWidth;}
   public int getUpY() { return y;}
   public int getDownY() { return y + cluesHeight;}
   public int getMidX() { return x + cluesWidth/2;}
   public int getMidY() { return y + cluesHeight/2;}
 }
 public interface ShowClass           //interface
 {
   public abstract void display();
 }
 public abstract class UpperClass         //abstract class
 {
   public abstract void update();
   public abstract void display();
 }
     
