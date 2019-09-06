class Game extends GameState {

  //MainMenu Class to provide first interaction with the game and basic information.
  //Used to start and end the game.
  
  //GameObjects may be generated in loadAssets if the resources is not required anywhere else
  private GameObject gameWallpaper;
  private GameObject fanBeltLeft, fanBeltRight, driveLeft, driveRight, pistonLeft, pistonRight, gasBarLeft, gasBarRight;
  private ArrayList<Sprite> fanBeltImgs, driveImgs;
  private Sprite pistonLeftImg, pistonRightImg;
  private boolean gameStarted = false;
  private PlayerContainer playerOne, playerTwo;
  private int secondsToStart = 4, secondsLeft;
  private float startTime, secondCountTime;
  //resources
  
  public Game() {
    super("Game");
    Tools.log("Created Game!",this);
  }

  void beforeInit() {
    Tools.log("Going into Game soon.",this);
  }

  void beforeEnd() {
    Tools.log("Exiting Game soon.",this);
  }
  //setup the scene.
  void start() {
    //prequesites 
    secondsLeft = secondsToStart;
    startTime = millis();
    secondCountTime = startTime;
    //create GameObject for game background
    spawn(gameWallpaper);
    
    //init players
    playerOne = new PlayerContainer(1);
    playerTwo = new PlayerContainer(2);
    playerOne.setOpponent(playerTwo);
    playerTwo.setOpponent(playerOne);
    
    spawn(playerOne);
    spawn(playerTwo);
    //playerOne.setOpponent(playerTwo);
    //playerTwo.setOpponent(playerOne);
    
    //init gameobjects
    fanBeltLeft = new GameObject(new Animation(fanBeltImgs,100));
    fanBeltRight = new GameObject(new Animation(fanBeltImgs,100));
    driveLeft = new GameObject(new Animation(driveImgs,100));
    driveRight = new GameObject(new Animation(driveImgs,100));
    driveRight.getAnimation().setFrame(6);
    pistonLeft = new GameObject(pistonLeftImg);
    pistonRight = new GameObject(pistonRightImg);
    
    //setup drives
    driveLeft.setPosition(54,height/2);
    driveLeft.setRotation(90);
    driveLeft.getAnimation().pause();
    spawn(driveLeft);
    
    driveRight.setPosition(width-54,height/2);
    driveRight.setRotation(-90);
    driveRight.getAnimation().pause();
    spawn(driveRight);
    
    //setup other player components
    fanBeltLeft.setPosition(48,64);
    fanBeltLeft.setRotation(90);
    fanBeltLeft.getAnimation().pause();
    spawn(fanBeltLeft);

    fanBeltRight.setPosition(width-48,height-64);
    fanBeltRight.setRotation(-90);
    fanBeltRight.getAnimation().pause();
    spawn(fanBeltRight);
    
    pistonLeft.setPosition(8,height/2+24);
    spawn(pistonLeft);
    pistonRight.setPosition(width-8,height/2-24);
    spawn(pistonRight);
   
    //UI
    gasBarLeft = new UIBar(color(100,1,1,1));
    gasBarLeft.setPosition(24,height-24);
    spawn(gasBarLeft);
    gasBarRight = new UIBar(color(100,1,1,1));
    gasBarRight.setPosition(width-24,24);
    spawn(gasBarRight);
  }
  
  //called when the countdown finished
  private void startGame() {
    gameStarted = true;
    //start animations on start
    driveLeft.getAnimation().resume();
    driveRight.getAnimation().resume();
    fanBeltLeft.getAnimation().resume();
    fanBeltRight.getAnimation().resume();
    
  }
  
  //Main logic of this gamestate.
  //Gets called within update cycle.
  void logic() {
    
    //prewarm
    if(secondsLeft > 0) {
      if(millis() - secondCountTime > 1000) {
         secondsLeft--; 
         secondCountTime = millis();
      }
    }
    else if(secondsLeft <= 0 && !gameStarted) {
      startGame();
    }
    //execute some logic if game is running
    if(gameStarted) {
      //jitter piston
      pistonLeft.setPosition(pistonLeft.getPosition().x,pistonLeft.getPosition().y+cos(frameCount));
      pistonRight.setPosition(pistonRight.getPosition().x,pistonRight.getPosition().y+sin(frameCount));
      fanBeltLeft.setPosition(fanBeltLeft.getPosition().x,fanBeltLeft.getPosition().y+cos(frameCount)*2.3);
      fanBeltRight.setPosition(fanBeltRight.getPosition().x,fanBeltRight.getPosition().y+sin(frameCount)*2.7);
      
      //move player piston into required position
      
      
      //check if game is over
      
      //one player reached other end?
    }
  }
  //Main render function of this gamestate.
  //Gets called within draw cycle.
  void render() {

  }
  
  //can be used for UI
  void afterDraw() {
    if(!gameStarted) {
      //render countdown
      renderCountdown();
    }
  }
  
  //function to fill a member of this class with all required ressources for the application.
  void loadAssets() {
    gameWallpaper = new GameObject(new Sprite(loadImage("assets/img/static/gameWallpaper.png")));
    
    fanBeltImgs = new ArrayList<Sprite>();
    for(int i = 1; i <= 5; i++) {
      fanBeltImgs.add(new Sprite(loadImage("assets/img/gameobjects/fanBelt"+i+".png")));
    }
    driveImgs = new ArrayList<Sprite>();
    for(int i = 1; i <= 12; i++) {
      driveImgs.add(new Sprite(loadImage("assets/img/gameobjects/drive"+i+".png")));
    } 
    pistonLeftImg = new Sprite(loadImage("assets/img/gameobjects/pistonLeft.png"));
    pistonRightImg = new Sprite(loadImage("assets/img/gameobjects/pistonRight.png"));
    
  }
  
  private void renderCountdown() {
        pushStyle();
      //blackBars
      fill(0,0,0,0.5);
      noStroke();
      rect(0,0,64,height);
      rect(width-64,0,width-64,height);
      popStyle();
      pushMatrix();
        float padding = 8;
        float lightWidth = ((height-64-padding*2)/secondsToStart);
        
        for(int i = secondsToStart; i > 0; i--) {
          pushStyle();
            strokeWeight(3);
            if(i > secondsLeft) {
              fill(0,0,0,0.3);
            }
            else {
              fill(1,1,1,1); 
            }
            ellipse(width/2,lightWidth*i+padding*i,lightWidth,lightWidth);
          popStyle();
        }
      popMatrix();
  }
}