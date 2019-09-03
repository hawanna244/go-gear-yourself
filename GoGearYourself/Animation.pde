class Animation {
  
  //Animations are similiar to sprite classes but extend them to hold an array of images and handling animation relevant logic in addition to basic image manipulation.
  ArrayList<Sprite> images;
  private boolean run = false;
  private float delay = 100, lastTimeRender;
  
  int imgIterator = 0;
  
  public Animation(ArrayList<Sprite> imgs, int delay) {
    this.images = imgs;
    this.delay = delay;
  }
  
  public void update() {
    if(run) {
      checkForUpdate();
      images.get(imgIterator).update(); //update single sprite (current)
    }
  }
  
  public void render() {
    images.get(imgIterator).render();
  }
  
  public void start() {
    imgIterator = 0;
    lastTimeRender = millis();
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
  
  //may th eimage changed based on speed?
  private void checkForUpdate() {
      
      if(millis() >= lastTimeRender + delay) {
        lastTimeRender = millis();
        imgIterator++;
      }
    
      if(imgIterator >= images.size()) {
        imgIterator = 0;
      }
  }
  
  public void setFrame(int f) {
    imgIterator = f%images.size();
  }
  
  public void setDelay(float newDelay) {
    this.delay = newDelay;
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
