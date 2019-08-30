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
      image(0,0,img);
    }
  }

}
