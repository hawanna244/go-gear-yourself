class Game extends GameState {

  //MainMenu Class to provide first interaction with the game and basic information.
  //Used to start and end the game.
  
  //GameObjects may be generated in loadAssets if the resources is not required anywhere else
  private GameObject gameWallpaper;
  private GameObject fanBeltLeft, fanBeltRight, driveLeft, driveRight, pistonLeft, pistonRight;
  private ArrayList<Sprite> fanBeltImgs, driveImgs;
  private Sprite pistonLeftImg, pistonRightImg;
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
    //TODO:
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
    spawn(driveLeft);
    
    driveRight.setPosition(width-54,height/2);
    driveRight.setRotation(-90);
    spawn(driveRight);
    
    fanBeltLeft.setPosition(48,64);
    fanBeltLeft.setRotation(90);
    spawn(fanBeltLeft);

    fanBeltRight.setPosition(width-48,height-64);
    fanBeltRight.setRotation(-90);
    spawn(fanBeltRight);
    
    pistonLeft.setPosition(16,height/2+24);
    spawn(pistonLeft);
    pistonRight.setPosition(width-16,height/2-24);
    spawn(pistonRight);
  }
  //Main logic of this gamestate.
  //Gets called within update cycle.
  void logic() {
    //jitter piston
    pistonLeft.setPosition(pistonLeft.getPosition().x,pistonLeft.getPosition().y+cos(frameCount));
    pistonRight.setPosition(pistonRight.getPosition().x,pistonRight.getPosition().y+sin(frameCount));
  }
  //Main render function of this gamestate.
  //Gets called within draw cycle.
  void render() {

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
}
