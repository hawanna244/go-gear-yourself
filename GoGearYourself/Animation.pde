class Animation {
  
  //Animations are similiar to sprite classes but extend them to hold an array of images and handling animation relevant logic in addition to basic image manipulation.
  ArrayList<PImage> images;
  int imgIterator = 0;
  
  public Animation(ArrayList<PImage> imgs) {
    this.images = imgs;
  }
  
  public void update() {
    
  }
  
  public void render() {
    
  }
  
  public float getWidth() {
    return this.getCurrentImage().width;
  }
  public float getHeight() {
    return this.getCurrentImage().height;
  }
  public float getScreenWidth() {
    return this.getWidth()*Tools.pixelFactor();
  }
  public float getScreenHeight() {
    return this.getHeight()*Tools.pixelFactor();
  }
  public PImage getCurrentImage() {
      return images.get(imgIterator);
  }
}
