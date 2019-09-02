public static class Tools {
  //some asset helper vars
  public static PImage loadingWallpaper;
  
  //Some global tools.
  private static ArrayList<GameState> gameStates;
  //used for external state calls.
  public static void stateTransit(GameState from, String toName) {
    from.end();
    findGameStateByName(toName).init();
  }
  //register for tool usage
  public static void registerStates(ArrayList<GameState> gs) {
     gameStates = gs; 
  }
  
  //Logging
  public static void log(String msg, Object caller) {
    if(GoGearYourself.debug) {
      println(caller.getClass().getName()+": "+msg);
    }
  }
  public static void log(String msg) {
    println("System: "+msg);
  }
  
  //global image scaling
  public static float pixelFactor() {
     return 4; 
  }
  
  //return a desired gamestate
  public static GameState findGameStateByName(String name) {
    GameState found = null;
    for(int i = 0; i < gameStates.size(); i++) {
       if(gameStates.get(i).getTitle().equals(name)) {
         found = gameStates.get(i);
       }
    }
    if(found == null) {
       throw new RuntimeException("Game State not found!"); 
    }
    return found;
  }
}