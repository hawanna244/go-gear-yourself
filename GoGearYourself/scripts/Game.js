class Game extends GameState {

  //MainMenu Class to provide first interaction with the game and basic information.
  //Used to start and end the game.


  constructor() {
    super("Game");
    Tools.log("Created Game!",this);
    this.gearImage = {};
  }

  beforeInit() {
    Tools.log("Going into Game soon.",this);
  }

  beforeEnd() {
    Tools.log("Exiting Game soon.",this);
  }
  //setup the scene.
  start() {
    //TODO:
    let gear = new GameObject(new Sprite(this.gearImage));
    this.spawn(gear);
  }
  //Main logic of this gamestate.
  //Gets called within update cycle.
  logic() {

  }
  //Main render function of this gamestate.
  //Gets called within draw cycle.
  render() {
    this.displayLoadingState();
  }
  //function to fill a member of this class with all required ressources for the application.
  //TODO
  async loadAssets(cb) {
    let finished = false;
    this.gearImage = await loadImage('assets/img/gameobjects/gear.png');
    cb();
  }

  //override
  onKeyPressed(keyCode) {

  }
}
