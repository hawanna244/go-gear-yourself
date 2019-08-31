import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class GoGearYourself extends PApplet {


/*
Go Gear Yourself
Created for ClockworkPi GameJam 2019 Q3
*/

//Global settings
boolean debug = true;
String version = "1.0.0";

//Global objects
ArrayList<GameState> gameStates; //Dont use an array here since we want to access the states later by name.


//Build this application up.
public void setup() {
  Tools.log("⚙️ Welcome to Go Gear Yourself! ⚙️");
  Tools.log("Debugging is enabled.");

  // put setup code here
  // //prevent scrollbars
  //size(320,240);
  fullScreen();
  colorMode(HSB,360,1,1,1); //color setup
  

  //Build loading GameState to show.
  //Manual State handling outside of update/draw to show something before other assets are loaded.
  Tools.log("Loading resources...");

  //loading global assets now.
  loadAssets();
  //gameStates.loading.end();

  //Build other GameStates
  Tools.log("Building GameStates...");
  gameStates = new ArrayList<GameState>();
  gameStates.add(new MainMenu());
  gameStates.add(new Game());
  Tools.registerStates(gameStates);
  
  //Launch
  Tools.log("Launching MainMenu...");
  Tools.findGameStateByName("MainMenu").init();
}

public void draw() {
  //update engine before rendering
  update();
  // put drawing code here

  //wipe screen
  background(0,0,1,1);
  //handle gamestates
  for(int i = 0; i < gameStates.size(); i++){
    if(gameStates.get(i).active()) {
      gameStates.get(i).draw();
    }
  }

  //debugging visuals
  if(debug) {
    debugInfo();
  }
}

public void update() {
  //update game logic

  //update Gamestates
  for(int i = 0; i < gameStates.size(); i++){
    if(gameStates.get(i).active()) {
      gameStates.get(i).update();
    }
  }
}

public void loadAssets() {
  //function to fill Tool.assets with all required ressources for the global main application e.g. fonts.
  Tools.log("Loading Assets...");
  Tools.loadingWallpaper = loadImage("assets/img/static/loadingWallpaper.png");
}

//inform all gamestates about the pressed key
public void keyPressed() {
  for(int i = 0; i < gameStates.size(); i++){
    if(gameStates.get(i).active()) {
      gameStates.get(i).onKeyPressed(keyCode);
    }
  }
}

public void debugInfo() {
  //print some useful information on the screen
  pushMatrix();
  pushStyle();
  translate(10,20);
  fill(0,1,1,1);
  text("GoGearYourself Debug",0,0);
  text("Version: "+version,0,20);
  //update Gamestates
    for(int i = 0; i < gameStates.size(); i++){
    if(gameStates.get(i).active()) {
      text("Current State: "+gameStates.get(i).title,0,40);
    }
  }
  text("FPS: "+frameRate,0,60);
  popMatrix();
  popStyle();
}
class Animation {
  
  //Animations are similiar to sprite classes but extend them to hold an array of images and handling animation relevant logic in addition to basic image manipulation.
  ArrayList<PImage> images;
  int imgIterator = 0;
  
  public Animation(ArrayList<PImage> imgs) {
    this.images = imgs;
  }
  
  public void update() {
    
  }
  
  public void render() {
    
  }
  
  public float getWidth() {
    return this.getCurrentImage().width;
  }
  public float getHeight() {
    return this.getCurrentImage().height;
  }
  public float getScreenWidth() {
    return this.getWidth()*Tools.pixelFactor();
  }
  public float getScreenHeight() {
    return this.getHeight()*Tools.pixelFactor();
  }
  public PImage getCurrentImage() {
      return images.get(imgIterator);
  }
}
class Game extends GameState {

  //MainMenu Class to provide first interaction with the game and basic information.
  //Used to start and end the game.

  private PImage gearImage;

  public Game() {
    super("Game");
    Tools.log("Created Game!",this);
  }

  public void beforeInit() {
    Tools.log("Going into Game soon.",this);
  }

  public void beforeEnd() {
    Tools.log("Exiting Game soon.",this);
  }
  //setup the scene.
  public void start() {
    GameObject gear = new GameObject(new Sprite(gearImage));
    this.spawn(gear);
    //TODO:
    //create GameObject for Menu Background

    //Create GameObject for Logo

    //create GameObject for Interaction Hint string
  }
  //Main logic of this gamestate.
  //Gets called within update cycle.
  public void logic() {
 
  }
  //Main render function of this gamestate.
  //Gets called within draw cycle.
  public void render() {

  }
  //function to fill a member of this class with all required ressources for the application.
  //TODO
  public void loadAssets() {
    gearImage = loadImage("assets/img/gameobjects/gear.png");
  }

  //override
  public void onKeyPressed(int kc) {
    //start the game if key pressed
    this.moveToState("Game");

  }
}
class GameObject {

  //Subclasses of GameObject define the logic that is required to interact with other GameObjects.
  //This abstract class handles some events and required fields like coordinates and animations/sprites.
  Sprite sprite;
  Animation animation;
  float posX, posY, oldPosX, oldPosY;
  
  //assets have to be preloaded before construction
  public GameObject(Sprite sprite) {
    this.sprite = sprite;
    this.posX = width/2;
    this.posY = height/2;
  }
  public GameObject(Animation animation) {
    this.animation = animation;
    this.posX = width/2;
    this.posY = height/2;
  }

  //update this gameobject
  public void update() {
    this.behaviour();
    if(this.sprite != null) {
      this.sprite.update();
    }
    if(this.animation != null) {
      this.animation.update();
    }
  }

  //display this game object
  public void render() {
    pushMatrix();
    translate(this.posX,this.posY);
    if(this.sprite != null) { //if sprite is present
      this.sprite.render();
    }
    else if(this.animation != null) { //if animation is present
      this.animation.render();
    }
    popMatrix();
    if(debug) {
      this.debug();
    }
  }
  //Animation
  public Animation getAnimation() {
    return this.animation;
  }

  public Sprite getSprite() {
    return this.sprite;
  }

  //this function needs to be overridden to implement the subclass gameobject behaviour.
  public void behaviour() {
    Tools.log("⚠️ You should implement the method behaviour in "+this.getClass().getName()+" before using GameObjects. GameObjects need the behaviour function to implement their logic.");
  }
  //gets called from engine if key was pressed.
  public void onKeyPressed(int kc) {
    if(debug) {
      Tools.log("Key pressed in GameObject "+this.getClass().getName()+".⚠️ This GameObject doesn`t handle this event! KeyCode: "+kc);
    }
  }

  //render some boundaries
  public void debug() {
    pushMatrix();
    translate(this.posX,this.posY);
    rectMode(CENTER);
    noFill();
    stroke(0,1,1,1);
    if(this.sprite != null) {
      rect(0,0,this.sprite.getScreenWidth(),this.sprite.getScreenHeight());
    }
    else if(this.animation != null) {
      rect(0,0,this.animation.getScreenWidth(),this.animation.getScreenHeight());
    }
    popMatrix();
  }
}
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
  public boolean active() {
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
  public void moveToState(String to) {
    Tools.stateTransit(this,to);
  }
  //gets called from engine if key was pressed.
  public void onKeyPressed(int kc) {
    if(debug) {
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
  public void mayActivate() {
    this.active = true;
  }
  public void loadAssets() {
    //function to fill a member of this class with all required ressources for the main application.
    throw new UnsupportedOperationException("⚠️ You have to implement the method gatherAssets in "+this.title+"!");
  }
  public String getTitle() {
     return this.title; 
  }
}
class MainMenu extends GameState {

  //MainMenu Class to provide first interaction with the game and basic information.
  //Used to start and end the game.

  public MainMenu() {
    super("MainMenu");
    Tools.log("Created MainMenu!",this);
  }

  public void beforeInit() {
    Tools.log("Going into MainMenu soon.",this);
  }

  public void beforeEnd() {
    Tools.log("Exiting MainMenu soon.",this);
  }
  //setup the scene.
  public void start() {
    //TODO:
    //create GameObject for Menu Background

    //Create GameObject for Logo

    //create GameObject for Interaction Hint string
  }
  //Main logic of this gamestate.
  //Gets called within update cycle.
  public void logic() {

  }
  //Main render function of this gamestate.
  //Gets called within draw cycle.
  public void render() {
    this.displayLoadingState();
  }
  //function to fill a member of this class with all required ressources for the application.
  //TODO
  public void loadAssets() {
    
  }

  //override
  public void onKeyPressed(int kc) {
    //start the game if key pressed
    this.moveToState("Game");
  }
}
class Sprite {

  //The Sprite class holds an Image and provides some useful image manipulation functions.
  PImage img;
  public Sprite(PImage img) {
    this.img = img;
  }

  public void update() {
      //not really necessary
  }

  public void render() {
    if(this.img != null) {
      imageMode(CENTER);
      image(this.img,0,0,this.img.width*Tools.pixelFactor(),this.img.height*Tools.pixelFactor());
    }
  }
  public float getWidth() {
    return this.img.width;
  }
  public float getHeight() {
    return this.img.height;
  }
  public float getScreenWidth() {
    return this.getWidth()*Tools.pixelFactor();
  }
  public float getScreenHeight() {
    return this.getHeight()*Tools.pixelFactor();
  }
}
public static class Tools {
  //some asset helper vars
  public static PImage loadingWallpaper;
  
  //Some global tools.
  private static ArrayList<GameState> gameStates;
  //used for external state calls.
  public static void stateTransit(GameState from, String toName) {
    from.end();
    findGameStateByName(toName).init();
  }
  //register for tool usage
  public static void registerStates(ArrayList<GameState> gs) {
     gameStates = gs; 
  }
  
  //Logging
  public static void log(String msg, Object caller) {
    println(caller.getClass().getName()+": "+msg);
  }
  public static void log(String msg) {
    println("System: "+msg);
  }
  
  //global image scaling
  public static float pixelFactor() {
     return 4; 
  }
  
  //return a desired gamestate
  public static GameState findGameStateByName(String name) {
    GameState found = null;
    for(int i = 0; i < gameStates.size(); i++) {
       if(gameStates.get(i).getTitle().equals(name)) {
         found = gameStates.get(i);
       }
    }
    if(found == null) {
       throw new RuntimeException("Game State not found!"); 
    }
    return found;
  }
}
  public void settings() {  fullScreen();  noSmooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "GoGearYourself" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
