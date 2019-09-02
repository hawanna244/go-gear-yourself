class Animation {
  
  //Animations are similiar to sprite classes but extend them to hold an array of images and handling animation relevant logic in addition to basic image manipulation.
  ArrayList<Sprite> images;
  private boolean run = false;
  int imgIterator = 0;
  
  public Animation(ArrayList<Sprite> imgs) {
    this.images = imgs;
  }
  
  public void update() {
    if(run) {
      imgIterator++;
      if(imgIterator >= images.size()) {
        imgIterator = 0;
      }
      images.get(imgIterator).update(); //update single sprite (current)
    }
  }
  
  public void render() {
    images.get(imgIterator).render();
  }
  
  public void start() {
    imgIterator = 0;
    run = true;
  }
  
  public void stop() {
    imgIterator = 0;
    run = false;
  }
  
  public void pause() {
    run = false;
  }
  
  public void resume() {
    run = true;
  }
  
  public boolean isRunning() {
    return run;
  }
  
  public float getWidth() {
    return this.getCurrentSprite().getWidth();
  }
  public float getHeight() {
    return this.getCurrentSprite().getHeight();
  }
  public float getScreenWidth() {
    return this.getCurrentSprite().getScreenWidth();
  }
  public float getScreenHeight() {
    return this.getCurrentSprite().getScreenHeight();
  }
  public Sprite getCurrentSprite() {
      return images.get(imgIterator);
  }
}