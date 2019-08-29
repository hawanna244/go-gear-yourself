class Loading extends GameState {

  //Loading state to display content while loading resources

  constructor() {
    super("Loading");
    Tools.log("Created Loading Screen!",this);
  }

  beforeInit() {
    Tools.log("Going into MainMenu soon.",this);
  }

  beforeEnd() {
    Tools.log("Exiting MainMenu soon.",this);
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
  //gather from Tool.assets since these assets where preloaded for this specific state.
  loadAssets(cb) {
    cb();
  }
}
