class MainMenu extends GameState {

  //MainMenu Class to provide first interaction with the game and basic information.
  //Used to start and end the game.

  public MainMenu() {
    super("MainMenu");
    Tools.log("Created MainMenu!",this);
  }

  void beforeInit() {
    Tools.log("Going into MainMenu soon.",this);
  }

  void beforeEnd() {
    Tools.log("Exiting MainMenu soon.",this);
  }
  //setup the scene.
  void start() {
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
    this.displayLoadingState();
  }
  //function to fill a member of this class with all required ressources for the application.
  //TODO
  void loadAssets() {
    
  }

  //override
  void onKeyPressed(int kc) {
    //start the game if key pressed
    this.moveToState("Game");
  }
}
