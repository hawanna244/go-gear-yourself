package de.xdstudios;

import processing.core.PApplet;
import processing.core.PImage;

import java.util.ArrayList;


public class GameState extends PApplet implements  IState{

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
  public void init() {
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
  public void start() {
    throw new UnsupportedOperationException("⚠️ You have to implement the method start in "+this.title+"! It is required to setup the scene and initial game logic.");
  }

  //Render this state.
  public void draw() {
    this.beforeDraw();
      //display overridden style
      this.render();
      //display objects
      this.gameObjectRender();
    this.afterDraw();
  }
  //Update this state.
  public void update() {
    this.beforeUpdate();
      //update this states logic
      this.logic();
      //update all gameObjects automati
      this.gameObjectUpdate();
    this.afterUpdate();
  }
  //Exit state.
  public void end() {
    this.beforeEnd();
    this.active = false;
  }
  //Spawn a game object and register it in this state after creation.
  //The gameObject needs to be added to the state and can be prepared before to ensure correct behaviour.
  public void spawn(GameObject go) {
    this.gameObjects.add(go);
  }
  //destroy a game object.
  public void destroy(GameObject go) {
    throw new UnsupportedOperationException("Not implemented!");
  }
  public void gameObjectUpdate() {
    for(int i = 0; i < this.gameObjects.size(); i++) {
      this.gameObjects.get(i).update();
    }
  }
  public void gameObjectRender() {
    for(int i = 0; i < this.gameObjects.size(); i++) {
      this.gameObjects.get(i).render();
    }
  }
  //tell if this state is active or not
  public boolean isActive() {
    return this.active;
  }
  //Just show aloading screen image
  public void displayLoadingState() {
    pushMatrix();
      background(0,0,0,1);
      translate(0,0);
      image(loadingWallpaper,0,0,loadingWallpaper.width*Tools.pixelFactor(),loadingWallpaper.height*Tools.pixelFactor());
    popMatrix();
  }
  //Functions to be overridden by subclasses:
  //Prequesites before initialization.
  public void beforeInit() {
    //Should be overridden.
    throw new UnsupportedOperationException("You have to implement the method beforeInit in "+this.title+"!");
  }
  //Executed before draw.
  public void beforeDraw() {
    //May be overridden.
    //throw new Exception("You have to implement the method beforeDraw!");
  }
  //Executed after draw.
  public void afterDraw() {
    //May be overridden.
    //throw new Exception("You have to implement the method afterDraw!");
  }
  //Executed before update.
  public void beforeUpdate() {
    //May be overridden.
    //throw new Exception("You have to implement the method beforeUpdate!");
  }
  //Executed after update.
  public void afterUpdate() {
    //May be overridden.
    //throw new Exception("You have to implement the method afterUpdate!");
  }
  //detach this state and move to next one
  void moveToState(String to) {
    Tools.stateTransit(this,to);
  }
  //gets called from engine if key was pressed.
  public void onKeyPressed(int kc) {
    if(Tools.debug) {
      Tools.log("Key pressed in GameState "+this.getClass().getName()+".⚠️ This GameState doesn`t handle this event! KeyCode: "+kc);
    }
    for(int i = 0; i < this.gameObjects.size(); i++) {
      this.gameObjects.get(i).onKeyPressed(kc);
    }
  }
  //Prepare state to sleep before the application stops using it.
  public void beforeEnd() {
    //Should be overridden.
    throw new UnsupportedOperationException("⚠️ You have to implement the method beforeEnd in "+this.title+"!");
  }
  //Main logic of this gamestate.
  //Gets called within update cycle.
  public void logic() {
    throw new UnsupportedOperationException("⚠️ You have to implement the method logic in "+this.title+"!");
  }
  //Main render function of this gamestate.
  //Gets called within draw cycle.
  public void render() {
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
