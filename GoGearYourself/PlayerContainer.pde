class PlayerContainer extends GameObject {
 
  //Class to implement interaction, calculations and GameObjects that build up the whole player Interface.
  //This PlayerContainer handles the basics. Right and Left can be subclasses of this player to handle orientations etc. 
  //GameLogic between Players belong to the GameState Game.
  //Before implementing new functions think about: 
  //Should they be placed in the Engine eg. in GameState or GameObject?
 
  private float maxGasAmount = 100, 
                currentGasAmount = 100,
                score = 0.5;
                
  private int minGear = 1, maxGear = 6, currentGear = 1, playerPosition = 1;
  
  private PlayerContainer opponent; //used to receive other values
  
  
  private boolean shifting = false, hasContact = false;

  public PlayerContainer(int position) {
    this.playerPosition = position;
  }
  //register opponent
  public void setOpponent(PlayerContainer opponent) {
    this.opponent = opponent;
  }
  //get remaining gas of the current player
  public float getGasRemaining() {
    return currentGasAmount;
  }
  
  public float getMaxGas() {
    return maxGasAmount;
  }
  
  public int getCurrentGear() {
    return currentGear;
  }
  
  public float getScore() {
    return score;
  }
  
  public void render() {
    //rendering is position dependend and done in game state via GameObject routine
  }
  
  public void behaviour() {
    //check for opponent. player wont work without
    if(this.opponent == null) {
      throw new UnsupportedOperationException("PlayerContainer require an opponent to calculate values! (Player "+this.playerPosition+")");
    }
    
    //check if we have contact
    if(this.hasContact) {
    
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
      shifting = true;
  }
  
  public void unshift() {
      shifting = false;
  }
  
  public boolean isShifting() {
    return shifting;
  }
  
  public void pushGas() {
     if(!isShifting()) {
       if(hasContact) {
         //calculate current score. compare to opponent torque and save result.
         //e.g. torque 5 and torque 10 result in 0.25 and 0.75 score. This is the score to calculate the contact movement from the center (both 0.5).
         //a score of 0.75 causes the piston to move in favor of the leading player with the main piston speed * 0.75 to the opponent.
       }
       else {
       
       }
     }
  }
  //set flag to know if this player is on contact
  public void hasContactWithOtherPlayer(boolean contact) {
    this.hasContact = contact;
  }
  
  //the player did a wrong input and loses some stuff / screenshake / release particles
  public void punish() {
    
  }
  //sets the current score and furthermore the piston position
  //calculated in gameState
  public void setScore(float s) {
    this.score = s;
  }
  
  //give some info about this player
  public int getPlayerPosition() {
    return playerPosition;
  }
  
  //return calculated player force / potency
  public float getTorque() {
      return 1.0;
  }
}