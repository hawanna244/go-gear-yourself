class MainMenu extends GameState {

  //MainMenu Class to provide first interaction with the game and basic information.
  //Used to start and end the game.

  constructor() {
    super("MainMenu");
    Tools.log("Created MainMenu!",this);
  }

  beforeInit() {
    Tools.log("Going into MainMenu soon.",this);
  }

  beforeEnd() {
    Tools.log("Exiting MainMenu soon.",this);
  }
  //setup the scene.
  start() {
    //TODO:
    //create GameObject for Menu Background

    //Create GameObject for Logo

    //create GameObject for Interaction Hint string
  }
  //Main logic of this gamestate.
  //Gets called within update cycle.
  logic() {

  }
  //Main render function of this gamestate.
  //Gets called within draw cycle.
  render() {

  }
  //function to fill a member of this class with all required ressources for the application.
  //TODO
  loadAssets(cb) {
    cb();
  }

  //override
  onKeyPressed(keyCode) {
    //start the game if key pressed
    this.moveToState("Game");

  }
}
