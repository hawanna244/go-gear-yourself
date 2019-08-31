package de.xdstudios;

import processing.core.PApplet;


public class GameObject {

  //Subclasses of GameObject define the logic that is required to interact with other GameObjects.
  //This abstract class handles some events and required fields like coordinates and animations/sprites.
  Sprite sprite;
  Animation animation;
  float posX, posY, oldPosX, oldPosY;
  
  //assets have to be preloaded before construction
  public GameObject(Sprite sprite) {
    this.sprite = sprite;
    this.posX = Tools.app.width/2;
    this.posY = Tools.app.height/2;
  }
  public GameObject(Animation animation) {
    this.animation = animation;
    this.posX = Tools.app.width/2;
    this.posY = Tools.app.height/2;
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
    Tools.app.pushMatrix();
    Tools.app.translate(this.posX,this.posY);
    if(this.sprite != null) { //if sprite is present
      this.sprite.render();
    }
    else if(this.animation != null) { //if animation is present
      this.animation.render();
    }
    Tools.app.popMatrix();
    if(Tools.debug) {
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
  void behaviour() {
    Tools.log("⚠️ You should implement the method behaviour in "+this.getClass().getName()+" before using GameObjects. GameObjects need the behaviour function to implement their logic.");
  }
  //gets called from engine if key was pressed.
  public void onKeyPressed(int kc) {
    if(Tools.debug) {
      Tools.log("Key pressed in GameObject "+this.getClass().getName()+".⚠️ This GameObject doesn`t handle this event! KeyCode: "+kc);
    }
  }

  //render some boundaries
  void debug() {
    Tools.app.pushMatrix();
    Tools.app.pushStyle();
    Tools.app.translate(this.posX,this.posY);
    Tools.app.rectMode(Tools.app.CENTER);
    Tools.app.noFill();
    Tools.app.stroke(0,1,1,1);
    if(this.sprite != null) {
      Tools.app.rect(0,0,this.sprite.getScreenWidth(),this.sprite.getScreenHeight());
    }
    else if(this.animation != null) {
      Tools.app.rect(0,0,this.animation.getScreenWidth(),this.animation.getScreenHeight());
    }
    Tools.app.popStyle();
    Tools.app.popMatrix();
  }
}
