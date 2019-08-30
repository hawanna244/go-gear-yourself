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

  constructor(sprite,animation) {

  }
  //update this gameobject
  update() {

  }
  //display this game object
  render() {
    push();
    translate(posX,posY);
    if(sprite) { //if sprite is present

    }
    else if(animation) { //if animation is present

    }
    pop();
    if(debug) {
      debug();
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
