class UIBar extends GameObject {
  
  //Class to display a common ui bar
  float maxValue = 100.0, currentValue = 100.0, dataHeight = 32, dataWidth = 8;
  color c;
  
  public UIBar(color c) {
    this.c = c;
  }
  
  public void display() {
    //in need of matrix operations since this function is excluded of transformations
    pushMatrix();
    pushStyle();
      translate(this.posX,this.posY);
      rectMode(CENTER);
      //value draw
      fill(c);
      rect(0,0,dataWidth,-32/maxValue*currentValue);
      //outer rects
      noFill();
      strokeWeight(4);
      rect(0,0,dataWidth,-dataHeight);
    popStyle();
    popMatrix();
  }
  
  //set the bar value in percent
  public void setValue(float percent) {
    if(percent <= maxValue && percent >= 0) {
      currentValue = percent;
    }
  }
}