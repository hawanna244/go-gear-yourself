class GameObject {

  //Subclasses of GameObject define the logic that is required to interact with other GameObjects.
  //This abstract class handles some events and required fields like coordinates and animations/sprites.
  #posX = 0;
  #posY = 0;
  #oldPosX = 0;
  #oldPosY = 0;
  #sprite = {};
  #animation = {};

  //assets have to be preloaded before construction
  constructor(sprite,animation = null) {
    this.#sprite = sprite;
    this.#animation = animation;
    this.#posX = width/2;
    this.#posY = height/2;
  }

  //update this gameobject
  update() {
    this.behaviour();
    if(this.#sprite) {
      this.#sprite.update();
    }
    if(this.#animation) {
      this.#animation.update();
    }
  }

  //display this game object
  render() {
    push();
    translate(this.#posX,this.#posY);
    if(this.#sprite) { //if sprite is present
      this.#sprite.render();
    }
    else if(this.#animation) { //if animation is present
      this.#animation.render();
    }
    pop();
    if(debug) {
      this.debug();
    }
  }
  //Animation
  getAnimation() {
    return this.#animation;
  }

  getSprite() {
    return this.#sprite;
  }

  //this function needs to be overridden to implement the subclass gameobject behaviour.
  behaviour() {
    Tools.log('⚠️ You should implement the method behaviour in '+this.constructor.name+' before using GameObjects. GameObjects need the behaviour function to implement their logic.');
  }
  //gets called from engine if key was pressed.
  onKeyPressed(keyCode) {
    if(debug) {
      Tools.log('Key pressed in GameObject '+this.constructor.name+'.⚠️ This GameObject doesn`t handle this event! KeyCode: '+keyCode);
    }
  }

  //render some boundaries
  debug() {
    push();
    translate(this.#posX,this.#posY);
    rectMode(CENTER);
    noFill();
    stroke(0,1,1,1);
    if(this.#sprite) {
      rect(0,0,this.#sprite.getScreenWidth(),this.#sprite.getScreenHeight());
    }
    else if(this.#animation) {
      rect(0,0,this.#animation.getScreenWidth(),this.#animation.getScreenHeight());
    }
    pop();
  }
}
