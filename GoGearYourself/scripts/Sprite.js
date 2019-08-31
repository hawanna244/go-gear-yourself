class Sprite {

  //The Sprite class holds an Image and provides some useful image manipulation functions.
  img = {};

  constructor(img) {
    this.img = img;
  }

  update() {
      //not really necessary
  }

  render() {
    if(this.img) {
      imageMode(CENTER);
      image(this.img,0,0,this.img.width*Tools.const.pixelFactor,this.img.height*Tools.const.pixelFactor);
    }
  }
  getWidth() {
    return this.img.width;
  }
  getHeight() {
    return this.img.height;
  }
  getScreenWidth() {
    return this.getWidth()*Tools.const.pixelFactor;
  }
  getScreenHeight() {
    return this.getHeight()*Tools.const.pixelFactor;
  }
}
