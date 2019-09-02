abstract class PlayerContainer extends GameObject {
 
  //Class to implement interaction, calculations and GameObjects that build up the whole player Interface.
  //This PlayerContainer handles the basics. Right and Left can be subclasses of this player to handle orientations etc. 
  //GameLogic between Players belong to the GameState Game.
  //Before implementing new functions think about: 
  //Should they be placed in the Engine eg. in GameState or GameObject?
 
  private float maxGasAmount = 100, 
                currentGasAmount = 100;
  
  public PlayerContainer() {
    super(); 
  }
  //get remaining gas of the current player
  public float getGasRemaining() {
    return currentGasAmount;
  }
}