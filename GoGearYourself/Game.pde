class Game extends GameState {

  //MainMenu Class to provide first interaction with the game and basic information.
  //Used to start and end the game.

  private PImage gearImage;

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
    GameObject gear = new GameObject(new Sprite(gearImage));
    this.spawn(gear);
    //TODO:
    //create GameObject for Menu Background

    //Create GameObject for Logo

    //create GameObject for Interaction Hint string
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
    gearImage = loadImage("assets/img/gameobjects/gear.png");
  }

  //override
  void onKeyPressed(int kc) {

  }
}
