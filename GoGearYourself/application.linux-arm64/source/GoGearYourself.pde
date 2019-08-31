
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
void setup() {
  Tools.log("⚙️ Welcome to Go Gear Yourself! ⚙️");
  Tools.log("Debugging is enabled.");

  // put setup code here
  //fullScreen(); //prevent scrollbars
  //size(320,240);
  fullScreen();
  colorMode(HSB,360,1,1,1); //color setup
  noSmooth();

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

void draw() {
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

void update() {
  //update game logic

  //update Gamestates
  for(int i = 0; i < gameStates.size(); i++){
    if(gameStates.get(i).active()) {
      gameStates.get(i).update();
    }
  }
}

void loadAssets() {
  //function to fill Tool.assets with all required ressources for the global main application e.g. fonts.
  Tools.log("Loading Assets...");
  Tools.loadingWallpaper = loadImage("assets/img/static/loadingWallpaper.png");
}

//inform all gamestates about the pressed key
void keyPressed() {
  for(int i = 0; i < gameStates.size(); i++){
    if(gameStates.get(i).active()) {
      gameStates.get(i).onKeyPressed(keyCode);
    }
  }
}

void debugInfo() {
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
