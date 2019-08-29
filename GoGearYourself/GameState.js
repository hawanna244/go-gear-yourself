class GameState {

  //Abstract class to represent a game state with required functions to fit into the state mechanic.

  constructor(title) {
    this.title = title;
    this.active = false;
  }

  //Initialize this state.
  init() {
    beforeInit();
    this.active = true;
  }
  //Render this state.
  draw() {
    beforeDraw();
      render();
    afterDraw();
  }
  //Update this state.
  update() {
    beforeUpdate();
      logic();
    afterUpdate();
  }
  //Exit state.
  end() {
    beforeEnd();
    this.active = false;
  }

  //Functions to be overridden by subclasses:
  //Prequesites before initialization.
  beforeInit() {
    //Should be overridden.
    throw new Error('You have to implement the method beforeInit!');
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
    throw new Error('You have to implement the method beforeEnd!');
  }
  //Main logic of this gamestate.
  //Gets called within update cycle.
  logic() {
    throw new Error('You have to implement the method logic!');
  }
  //Main render function of this gamestate.
  //Gets called within draw cycle.
  render() {
    throw new Error('You have to implement the method render!');
  }
}
