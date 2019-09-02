class GameState {

  //Abstract class to represent a game state with required functions to fit into the state mechanic.
  //Compare this to a scene in a play. GameObjects should be handled in a subclass of this.
  private boolean active = false; //should this state be handled?
  private String title;
  private ArrayList<GameObject> gameObjects; //all gameObjects within this state. Have to be registered.
  private PImage loadingWallpaper;
  
  public GameState(String title) { //build a gamestate
    this.title = title;
    this.loadingWallpaper = Tools.loadingWallpaper;
  }

  //Initialize this state. Always call init() to set this state active.
  //The main app automatically updates this state afterwards.
  void init() {
    Tools.log("Initializing GameState:"+this.title);
    this.displayLoadingState();
    this.beforeInit();
    this.gameObjects = new ArrayList<GameObject>();
    this.loadAssets();
    this.mayActivate();
    this.start();
    //TODO: Prevent setting active bevore all assets are done?
    //Handle this via loading screen is quite okay I guess.
  }

  //This function is required to be overridden by the subclass to initialize the current scene.
  void start() {
    throw new UnsupportedOperationException("⚠️ You have to implement the method start in "+this.title+"! It is required to setup the scene and initial game logic.");
  }

  //Render this state.
  void draw() {
    this.beforeDraw();
      //display overridden style
      this.render();
      //display objects
      this.gameObjectRender();
    this.afterDraw();
  }
  //Update this state.
  void update() {
    this.beforeUpdate();
      //update this states logic
      this.logic();
      //update all gameObjects automati
      this.gameObjectUpdate();
    this.afterUpdate();
  }
  //Exit state.
  void end() {
    this.beforeEnd();
    this.active = false;
  }
  //Spawn a game object and register it in this state after creation.
  //The gameObject needs to be added to the state and can be prepared before to ensure correct behaviour.
  void spawn(GameObject go) {
    go.setGameState(this);
    this.gameObjects.add(go);
  }
  //destroy a game object.
  void destroy(GameObject go) {
    this.gameObjects.remove(go);
  }
  void gameObjectUpdate() {
    //check collisions
    for(int i = 0; i < this.gameObjects.size(); i++) {
      this.checkGameObjectEvents(this.gameObjects.get(i));
      this.gameObjects.get(i).update();
    }
  }
  //let objects check egainst each other
  void checkGameObjectEvents(GameObject go) {
    for(int i = 0; i < this.gameObjects.size(); i++) {
      if(!this.gameObjects.get(i).equals(go)) {//dont compare to self
        go.checkEventsOn(this.gameObjects.get(i));
      }
    }
  }
  
  void gameObjectRender() {
    for(int i = 0; i < this.gameObjects.size(); i++) {
      this.gameObjects.get(i).render();
    }
  }
  //tell if this state is active or not
  boolean active() {
    return this.active;
  }
  //Just show aloading screen image
  void displayLoadingState() {
    pushMatrix();
      background(0,0,0,1);
      translate(0,0);
      image(loadingWallpaper,0,0,loadingWallpaper.width*Tools.pixelFactor(),loadingWallpaper.height*Tools.pixelFactor());
    popMatrix();
  }
  //Functions to be overridden by subclasses:
  //Prequesites before initialization.
  void beforeInit() {
    //Should be overridden.
    throw new UnsupportedOperationException("You have to implement the method beforeInit in "+this.title+"!");
  }
  //Executed before draw.
  void beforeDraw() {
    //May be overridden.
    //throw new Exception("You have to implement the method beforeDraw!");
  }
  //Executed after draw.
  void afterDraw() {
    //May be overridden.
    //throw new Exception("You have to implement the method afterDraw!");
  }
  //Executed before update.
  void beforeUpdate() {
    //May be overridden.
    //throw new Exception("You have to implement the method beforeUpdate!");
  }
  //Executed after update.
  void afterUpdate() {
    //May be overridden.
    //throw new Exception("You have to implement the method afterUpdate!");
  }
  //detach this state and move to next one
  void moveToState(String to) {
    Tools.stateTransit(this,to);
  }
  //gets called from engine if key was pressed.
  void handleKeyEvent(int kc) {
    this.onKeyPressed(kc);
    for(int i = 0; i < this.gameObjects.size(); i++) {
      this.gameObjects.get(i).onKeyPressed(kc);
    }
  }
  
  void onKeyPressed(int kc) {
    if(debug) {
      Tools.log("Key pressed in GameState "+this.getClass().getName()+".⚠️ This GameState doesn`t handle this event! KeyCode: "+kc);
    }
  }
  //Prepare state to sleep before the application stops using it.
  void beforeEnd() {
    //Should be overridden.
    throw new UnsupportedOperationException("⚠️ You have to implement the method beforeEnd in "+this.title+"!");
  }
  //Main logic of this gamestate.
  //Gets called within update cycle.
  void logic() {
    throw new UnsupportedOperationException("⚠️ You have to implement the method logic in "+this.title+"!");
  }
  //Main render function of this gamestate.
  //Gets called within draw cycle.
  void render() {
    throw new UnsupportedOperationException("⚠️ You have to implement the method render in "+this.title+"!");
  }
  //callback if this state may get active
  void mayActivate() {
    this.active = true;
  }
  void loadAssets() {
    //function to fill a member of this class with all required ressources for the main application.
    throw new UnsupportedOperationException("⚠️ You have to implement the method gatherAssets in "+this.title+"!");
  }
  public String getTitle() {
     return this.title; 
  }
}