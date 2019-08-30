class GameObject {

  //Subclasses of GameObject define the logic that is required to interact with other GameObjects.
  //This abstract class handles some events and required fields like coordinates and animations/sprites.
  #posX = 0;
  #posY = 0;
  #oldPosX = 0;
  #oldPosY = 0;
  #gWidth = 0;
  #gHeight = 0;
  #sprite = {};
  #animation = {};

  //assets have to be preloaded before construction
  constructor(sprite,animation) {
    this.#sprite = sprite;
    this.#animation = animation;
  }

  //update this gameobject
  update() {
    this.behaviour();
    if(sprite) {
      sprite.update();
    }
    if(animation) {
      animation.update();
    }
  }

  //display this game object
  render() {
    push();
    translate(posX,posY);
    if(sprite) { //if sprite is present
      sprite.render();
    }
    else if(animation) { //if animation is present
      animation.render();
    }
    pop();
    if(debug) {
      debug();
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
    throw Error('⚠️ You have to implement the method behaviour in '+this.constructor.name+' before using this subclass. GameObjects need the behaviour function to implement their logic.');
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
    translate(posX,posY);
    rectMode(CENTER);
    fill(0,1,1,1);
    rect(0,0,gWidth,gHeight);
    pop();
  }

}
