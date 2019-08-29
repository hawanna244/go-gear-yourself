
/*
  Go Gear Yourself
  Created for ClockworkPi GameJam 2019 Q3
*/

function setup() {
  // put setup code here
  createCanvas(318, 238); //prefent scrollbars
  colorMode(HSB,360,1,1,1); //color setup

}

function draw() {
  //update engine before rendering
  update();
  // put drawing code here
  translate(random(0,width),random(0,height));
  rectMode(CENTER);
  fill(frameCount%360,1,1,1);
  rect(0,0,20,20);
}

function update() {
    //update game logic
}
