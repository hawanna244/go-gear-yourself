class GameResult extends GameState {

  //MainMenu Class to provide first interaction with the GameResult and basic information.
  //Used to start and end the GameResult.

  private GameObject gameWallpaper;
  
  public GameResult() {
    super("GameResult");
    Tools.log("Created GameResult!",this);
  }

  void beforeInit() {
    Tools.log("Going into GameResult soon.",this);
  }

  void beforeEnd() {
    Tools.log("Exiting GameResult soon.",this);
  }
  //setup the scene.
  void start() {
    //TODO:
    //create GameResultObject for Menu Background
    spawn(gameWallpaper);
    //Create GameResultObject for Logo

    //create GameResultObject for Interaction Hint string
  }
  //Main logic of this GameResultstate.
  //Gets called within update cycle.
  void logic() {
 
  }
  //Main render function of this GameResultstate.
  //Gets called within draw cycle.
  void render() {

  }
  //function to fill a member of this class with all required ressources for the application.
  //TODO
  void loadAssets() {
    gameWallpaper = new GameObject(new Sprite(loadImage("assets/img/static/gameWallpaper.png")));
  }

  //override
  void onKeyPressed(int kc) {

  }
}
