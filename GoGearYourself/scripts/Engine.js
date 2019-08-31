
/*
Go Gear Yourself
Created for ClockworkPi GameJam 2019 Q3
*/

//Global settings
debug = true;
version = "1.0.0";

//Global objects
var Tools = { //Some global tools.
  assets: { //use Tools.assets to access already loaded resources e.g images. Included required files in loadAssets() function.
    logo:null,
    loadingWallpaper:null,
  },
  //used for external state calls.
  stateTransit:function(from,toName) {
    from.end();
    if(gameStates.hasOwnProperty(toName)) {
      gameStates[toName].init();
    }
  },
  log:function(msg,caller) {
    if(debug) {
      let name = "";
      if(!caller) {
        name = "System";
      }
      else {
        name = caller.constructor.name
      }
      console.log("ℹ️ "+name+": "+msg);
    }
  },
  const:{
    pixelFactor:4,
  }
};
var gameStates = {}; //Dont use an array here since we want to access the states later by name.

function preload() {
  //this function is used to preload some VERY IMPORTANT FILES.
  //E.g. images required for loading screen etc. Something we MUST have before starting the application.
  Tools.assets.loadingWallpaper = loadImage('assets/img/static/loadingWallpaper.png');
}

//Build this application up.
function setup() {
  Tools.log("⚙️ Welcome to Go Gear Yourself! ⚙️");
  Tools.log("Debugging is enabled.");

  // put setup code here
  createCanvas(318, 238); //prevent scrollbars
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
  gameStates.MainMenu = new MainMenu();
  gameStates.Game = new Game();

  //Launch
  Tools.log("Launching MainMenu...");
  gameStates.MainMenu.init();
}

function draw() {
  //update engine before rendering
  update();
  // put drawing code here

  //wipe screen
  background(0,0,1,1);
  //handle gamestates
  for(var gs in gameStates){
    if(gameStates[gs].active()) {
      gameStates[gs].draw();
    }
  }

  //debugging visuals
  if(debug) {
    debugInfo();
  }
}

function update() {
  //update game logic

  //update Gamestates
  for(var gs in gameStates){
    if(gameStates[gs].active()) {
      gameStates[gs].update();
    }
  }
}

function loadAssets() {
  //function to fill Tool.assets with all required ressources for the global main application e.g. fonts.
  Tools.log("Loading Assets...");
}

//inform all gamestates about the pressed key
function keyPressed() {
  for(var gs in gameStates){
    console.log(gameState[gs]);
    if(gameStates[gs].active()) {
      gameStates[gs].onKeyPressed(keyCode);
    }
  }
}

function debugInfo() {
  //print some useful information on the screen
  push();
  translate(10,20);
  color(0,0,0,1);
  text("GoGearYourself Debug",0,0);
  text("Version: "+version,0,20);
  //update Gamestates
  for(var gs in gameStates){
    if(gameStates[gs].active()) {
      text("Current State: "+gameStates[gs].title,0,40);
    }
  }
  text("FPS: "+frameRate().toFixed(0),0,60);
  pop();
}
