class GameState {

  //Abstract class to represent a game state with required functions to fit into the state mechanic.
  //Compare this to a scene in a play. GameObjects should be handled in a subclass of this.
  #active = false;

  constructor(title) {
    this.title = title;
  }

  //Initialize this state. Always call init() to set this state active.
  //The main app automatically updates this state afterwards.
  init() {
    Tools.log("Initializing GameState:"+this.title);
    this.beforeInit();
    let me = this;
    this.loadAssets(function(){me.#active = true});
    //TODO: Prevent setting active bevore all assets are done?
    //Handle this via loading screen is quite okay I guess.
  }
  //Render this state.
  draw() {
    this.beforeDraw();
      this.render();
    this.afterDraw();
  }
  //Update this state.
  update() {
    this.beforeUpdate();
      this.logic();
    this.afterUpdate();
  }
  //Exit state.
  end() {
    this.beforeEnd();
    this.#active = false;
  }

  active() {
    return this.#active;
  }

  //Functions to be overridden by subclasses:
  //Prequesites before initialization.
  beforeInit() {
    //Should be overridden.
    throw new Error('You have to implement the method beforeInit in '+this.title+'!');
  }
  //Executed before draw.
  beforeDraw() {
    //May be overridden.
    //throw new Error('You have to implement the method beforeDraw!');
  }
  //Executed after draw.
  afterDraw() {
    //May be overridden.
    //throw new Error('You have to implement the method afterDraw!');
  }
  //Executed before update.
  beforeUpdate() {
    //May be overridden.
    //throw new Error('You have to implement the method beforeUpdate!');
  }
  //Executed after update.
  afterUpdate() {
    //May be overridden.
    //throw new Error('You have to implement the method afterUpdate!');
  }
  //Prepare state to sleep before the application stops using it.
  beforeEnd() {
    //Should be overridden.
    throw new Error('⚠️ You have to implement the method beforeEnd in '+this.title+'!');
  }
  //Main logic of this gamestate.
  //Gets called within update cycle.
  logic() {
    throw new Error('⚠️ You have to implement the method logic in '+this.title+'!');
  }
  //Main render function of this gamestate.
  //Gets called within draw cycle.
  render() {
    throw new Error('⚠️ You have to implement the method render in '+this.title+'!');
  }
  //callback if this state may get active
  mayActivate() {
    this.#active = true;
  }
  loadAssets(callback) {
    //function to fill a member of this class with all required ressources for the main application.
    callback();
    throw new Error('⚠️ You have to implement the method gatherAssets in '+this.title+'! ⚠️ Executing callback is required for the state to start. Otherwise it will not activate after all resources where loaded.');
  }
}
