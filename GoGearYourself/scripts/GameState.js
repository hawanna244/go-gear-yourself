class GameState {

  //Abstract class to represent a game state with required functions to fit into the state mechanic.

  constructor(title) {
    this.title = title;
    this.active = false;
  }

  //Initialize this state. Always call init() to set this state active.
  //The main app automatically updates this state afterwards.
  init() {
    Tools.log("Initializing GameState:"+this.title);
    this.beforeInit();
    this.active = true;
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
    this.active = false;
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
    throw new Error('You have to implement the method beforeEnd in '+this.title+'!');
  }
  //Main logic of this gamestate.
  //Gets called within update cycle.
  logic() {
    throw new Error('You have to implement the method logic in '+this.title+'!');
  }
  //Main render function of this gamestate.
  //Gets called within draw cycle.
  render() {
    throw new Error('You have to implement the method render in '+this.title+'!');
  }
}
