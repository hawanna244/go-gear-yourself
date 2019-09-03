class Game extends GameState {

  //MainMenu Class to provide first interaction with the game and basic information.
  //Used to start and end the game.
  
  //GameObjects may be generated in loadAssets if the resources is not required anywhere else
  private GameObject gameWallpaper;
  private GameObject fanBeltLeft, fanBeltRight, driveLeft, driveRight, pistonLeft, pistonRight;
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
    
    secondsLeft = secondsToStart;
    startTime = millis();
    secondCountTime = startTime;
    //create GameObject for game background
    spawn(gameWallpaper);
    
    fanBeltLeft = new GameObject(new Animation(fanBeltImgs,100));
    fanBeltRight = new GameObject(new Animation(fanBeltImgs,100));
    driveLeft = new GameObject(new Animation(driveImgs,100));
    driveRight = new GameObject(new Animation(driveImgs,100));
    driveRight.getAnimation().setFrame(6);
    pistonLeft = new GameObject(pistonLeftImg);
    pistonRight = new GameObject(pistonRightImg);
    
    driveLeft.setPosition(54,height/2);
    driveLeft.setRotation(90);
    driveLeft.getAnimation().pause();
    spawn(driveLeft);
    
    driveRight.setPosition(width-54,height/2);
    driveRight.setRotation(-90);
    driveRight.getAnimation().pause();
    spawn(driveRight);
    
    fanBeltLeft.setPosition(48,64);
    fanBeltLeft.setRotation(90);
    fanBeltLeft.getAnimation().pause();
    spawn(fanBeltLeft);

    fanBeltRight.setPosition(width-48,height-64);
    fanBeltRight.setRotation(-90);
    fanBeltRight.getAnimation().pause();
    spawn(fanBeltRight);
    
    pistonLeft.setPosition(16,height/2+24);
    spawn(pistonLeft);
    pistonRight.setPosition(width-16,height/2-24);
    spawn(pistonRight);
  }
  
  private void startGame() {
    gameStarted = true;
    driveLeft.getAnimation().resume();
    driveRight.getAnimation().resume();
    fanBeltLeft.getAnimation().resume();
    fanBeltRight.getAnimation().resume();
    
  }
  
  //Main logic of this gamestate.
  //Gets called within update cycle.
  void logic() {
    
    if(secondsLeft > 0) {
      if(millis() - secondCountTime > 1000) {
         secondsLeft--; 
         secondCountTime = millis();
      }
    }
    else if(secondsLeft <= 0 && !gameStarted) {
      startGame();
    }
    
    if(gameStarted) {
      //jitter piston
      pistonLeft.setPosition(pistonLeft.getPosition().x,pistonLeft.getPosition().y+cos(frameCount));
      pistonRight.setPosition(pistonRight.getPosition().x,pistonRight.getPosition().y+sin(frameCount));
    }
  }
  //Main render function of this gamestate.
  //Gets called within draw cycle.
  void render() {

  }
  
  void afterDraw() {
    if(!gameStarted) {
      //render countdown
      renderCountdown();
    }
  }
  
  //function to fill a member of this class with all required ressources for the application.
  //TODO
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
