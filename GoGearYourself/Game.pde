class Game extends GameState {

  //MainMenu Class to provide first interaction with the game and basic information.
  //Used to start and end the game.
  
  //GameObjects may be generated in loadAssets if the resources is not required anywhere else
  private GameObject gameWallpaper;
  
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
  }
  //Main logic of this gamestate.
  //Gets called within update cycle.
  void logic() {
    
  }
  //Main render function of this gamestate.
  //Gets called within draw cycle.
  void render() {

  }
  //function to fill a member of this class with all required ressources for the application.
  //TODO
  void loadAssets() {
    gameWallpaper = new GameObject(new Sprite(loadImage("assets/img/static/gameWallpaper.png")));
  }
}