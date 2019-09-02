class PlayerContainer extends GameObject {
 
  //Class to implement interaction, calculations and GameObjects that build up the whole player Interface.
  //This PlayerContainer handles the basics. Right and Left can be subclasses of this player to handle orientations etc. 
  //GameLogic between Players belong to the GameState Game.
  //Before implementing new functions think about: 
  //Should they be placed in the Engine eg. in GameState or GameObject?
 
  private float maxGasAmount = 100, 
                currentGasAmount = 100;
  private int minGear = 1, maxGear = 6, currentGear = 1, playerPosition = 1;

  private GameObject piston;
  
  private boolean shifting = false;

  //get remaining gas of the current player
  public float getGasRemaining() {
    return currentGasAmount;
  }
  
  public void render() {
  
  }
  
  public void behaviour() {
    //logic is position dependend
    switch(playerPosition) {
       case 1:
       break;
       case 2:
       break;
    }
  }
  
  public void gearUp() {
    if(isShifting()) {
      if(currentGear < maxGear) {
         currentGear++; 
      }  
    }
    else {
       punish(); 
    }
  }
  
  public void gearDown() {
    if(isShifting()) {
     if(currentGear > minGear) {
        currentGear--; 
     }      
    }
    else {
       punish(); 
    }

  }
  
  public void shift() {
      
  }
  
  public void unshift() {
      
  }
  
  public boolean isShifting() {
    return shifting;
  }
  
  public void pushGas() {
     if(!isShifting()) {
       
     }
  }
  //the player did a wrong input and loses some stuff / screenshake / release particles
  public void punish() {
    
  }
}
