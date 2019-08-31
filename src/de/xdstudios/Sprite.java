package de.xdstudios;

import processing.core.PApplet;
import processing.core.PImage;


public class Sprite extends PApplet{


  //The Sprite class holds an Image and provides some useful image manipulation functions.
  PImage img;
  public Sprite(PImage img) {
    this.img = img;
  }

  void update() {
      //not really necessary
  }

  void render() {
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
