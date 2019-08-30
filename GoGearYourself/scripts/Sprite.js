class Sprite {

  //The Sprite class holds an Image and provides some useful image manipulation functions.
  #img = {};

  constructor(img) {
    this.#img = img;
  }

  update() {
      //not really necessary
  }

  render() {
    if(img) {
      imageMode(CENTER);
      image(img,0,0);
    }
  }

}
