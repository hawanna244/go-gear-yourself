class GameState {

  //Abstract class to represent a game state with required functions to fit into the state mechanic.
  //Compare this to a scene in a play. GameObjects should be handled in a subclass of this.

  active = false; //should this state be handled?
  gameObjects = []; //all gameObjects within this state. Have to be registered.
  loadingWallpaper = {};

  constructor(title) { //build a gamestate
    this.title = title;
  }

  //Initialize this state. Always call init() to set this state active.
  //The main app automatically updates this state afterwards.
  init() {
    Tools.log("Initializing GameState:"+this.title);
    this.displayLoadingState();
    this.beforeInit();
    let me = this;
    this.loadAssets(function(){
      me.active = true;
      me.start();
    });
    //TODO: Prevent setting active bevore all assets are done?
    //Handle this via loading screen is quite okay I guess.
  }

  //This function is required to be overridden by the subclass to initialize the current scene.
  start() {
    throw new Error('⚠️ You have to implement the method start in '+this.title+'! It is required to setup the scene and initial game logic.');
  }

  //Render this state.
  draw() {
    this.beforeDraw();
      //display overridden style
      this.render();
      //display objects
      this.gameObjectRender();
    this.afterDraw();
  }
  //Update this state.
  update() {
    this.beforeUpdate();
      //update this states logic
      this.logic();
      //update all gameObjects automati
      this.gameObjectUpdate();
    this.afterUpdate();
  }
  //Exit state.
  end() {
    this.beforeEnd();
    this.active = false;
  }
  //Spawn a game object and register it in this state after creation.
  //The gameObject needs to be added to the state and can be prepared before to ensure correct behaviour.
  spawn(go) {
    this.gameObjects.push(go);
  }
  //destroy a game object.
  destroy(go) {
    let index = this.gameObjects.indexOf(go);
    if(index !== -1) {
      this.gameObjects.splice(index, 1);
    }
  }
  gameObjectUpdate() {
    this.gameObjects.forEach(function(go){
      go.update();
    });
  }
  gameObjectRender() {
    this.gameObjects.forEach(function(go){
      go.render();
    });
  }
  //tell if this state is active or not
  active() {
    return this.active;
  }
  //Just show aloading screen image
  displayLoadingState() {
    push();
      background(0,0,0,1);
      translate(0,0);
      image(Tools.assets.loadingWallpaper,0,0,Tools.assets.loadingWallpaper.width*Tools.const.pixelFactor,Tools.assets.loadingWallpaper.height*Tools.const.pixelFactor);
    pop();
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
  //detach this state and move to next one
  moveToState(to) {
    Tools.stateTransit(this,to);
  }
  //gets called from engine if key was pressed.
  onKeyPressed(keyCode) {
    if(debug) {
      Tools.log('Key pressed in GameObject '+this.constructor.name+'.⚠️ This GameObject doesn`t handle this event! KeyCode: '+keyCode);
    }
    this.gameObjects.forEach(function(go){
      go.onKeyPressed(keyCode);
    });
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
    this.active = true;
  }
  async loadAssets(callback) {
    //function to fill a member of this class with all required ressources for the main application.
    callback();
    throw new Error('⚠️ You have to implement the method gatherAssets in '+this.title+'! ⚠️ Executing callback is required for the state to start. Otherwise it will not activate after all resources where loaded.');
  }
}
