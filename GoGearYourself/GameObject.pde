class GameObject {

  //Subclasses of GameObject define the logic that is required to interact with other GameObjects.
  //This abstract class handles some events and required fields like coordinates and animations/sprites.
  Sprite sprite;
  Animation animation;
  
  private ArrayList<GameObject> overlaps;
  private String tag = "undefined";
  private GameState gameState;
  float posX, posY, oldPosX, oldPosY, rotation = 0;
  
  //assets have to be preloaded before construction
  public GameObject() { //for empty GameObjects or GameObject Group Parents
    this.globalAfterConstruct();
  }
  
  public GameObject(Sprite sprite) { //For Sprites
    this.sprite = sprite;
    this.globalAfterConstruct();
  }
  public GameObject(Animation animation) { //For Animation
    this.animation = animation;
    this.animation.start();
    this.globalAfterConstruct();
  }

  protected void globalAfterConstruct() {
    this.posX = width/2;
    this.posY = height/2;
    this.overlaps = new ArrayList<GameObject>();
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
    pushMatrix();
    translate(this.posX,this.posY);
    if(this.sprite != null) { //if sprite is present
      this.sprite.render();
    }
    else if(this.animation != null) { //if animation is present
      this.animation.render();
    }
    popMatrix();
    if(GoGearYourself.debug) {
      this.debug();
    }
  }
  //Animation
  public Animation getAnimation() {
    if(this.animation != null) {
      return this.animation;
    }
    else {
       throw new UnsupportedOperationException("No Animation found on GameObject!"); 
    }
  }

  public Sprite getSprite() {
    if(this.sprite != null) {
      return this.sprite;
    }
    else if(this.animation != null) {
      return this.animation.getCurrentSprite();
    }
    else {
       throw new UnsupportedOperationException("No Sprite found on GameObject!"); 
    }
  }
  
  //set hard to position
  public void setPosition(float x, float y) {
      this.posX = x;
      this.posY = y;
  }
  public PVector getPosition() {
     return new PVector(this.posX,this.posY);
  }
  //compare yourself to this object and cause events
  public void checkEventsOn(GameObject go) {
    //rect intersection of combined dimensions of sprites calculated width/height and gameobjects position:
    if(this.gameObjectRectIntersection(go)){
      this.onOverlap(go);
    }
    else {
      this.onNotOverlap(go);
    }
    //check other events
  }
  //check for each still overlapping gameobjects if its new
  //call on collision enter if not known.
  public void onOverlap(GameObject go) { //DO NOT OVERRIDE
    if(this.overlaps.contains(go)) {
       this.onCollisionStay(go); 
    }
    else {
        this.overlaps.add(go);
        this.onCollisionEnter(go);
    }
  }
  //check for each still overlapping gameobjects if its new
  //call on collision exit if not known.
  public void onNotOverlap(GameObject go) { //DO NOT OVERRIDE
    if(this.overlaps.contains(go)) {
       this.overlaps.remove(go);
       this.onCollisionExit(go); 
    }
  }
  //event handler to be overridden
  public void onCollisionStay(GameObject go) {
     Tools.log("⚠Collision stays in "+this.getClass().getName()+" with "+go.getClass().getName()+"! This event is unhandled!");
  }
  //event handler to be overridden
  public void onCollisionEnter(GameObject go) {
      Tools.log("⚠Collision enter in "+this.getClass().getName()+" with "+go.getClass().getName()+"! This event is unhandled!");
  }
  //event handler to be overridden
  public void onCollisionExit(GameObject go) {
      Tools.log("⚠Collision exit in "+this.getClass().getName()+" with "+go.getClass().getName()+"! This event is unhandled!");
  }
  //this function needs to be overridden to implement the subclass gameobject behaviour.
  void behaviour() {
    //Log is not helpful
    //Tools.log("⚠️ You should implement the method behaviour in "+this.getClass().getName()+" before using GameObjects. GameObjects need the behaviour function to implement their logic.");
  }
  //gets called from engine if key was pressed.
  public void onKeyPressed(int kc) {
      Tools.log("Key pressed in GameObject "+this.getClass().getName()+".⚠️ This GameObject doesn`t handle this event! KeyCode: "+kc);
  }

  //render some boundaries
  void debug() {
    pushMatrix();
    pushStyle();
    translate(this.posX,this.posY);
    rectMode(CENTER);
    noFill();
    stroke(100,1,1,1);
    if(this.sprite != null) {
      rect(0,0,this.sprite.getScreenWidth(),this.sprite.getScreenHeight());
    }
    else if(this.animation != null) {
      rect(0,0,this.animation.getScreenWidth(),this.animation.getScreenHeight());
    }
    popStyle();
    popMatrix();
  }
  
  //check for rectangular overlapping gameobjects
  public boolean gameObjectRectIntersection(GameObject other) {
    //compare both sprites and position to call events:
    boolean overlap = true;
    Sprite mySprite = this.getSprite();
    Sprite otherSprite = other.getSprite();
    
    //Vars for better readability
    float left = this.posX - mySprite.getScreenWidth()/2; //divide by 2 because x marks the center
    float right = this.posX + mySprite.getScreenWidth()/2;
    float top = this.posY - mySprite.getScreenHeight()/2;
    float bottom = this.posY + mySprite.getScreenHeight()/2;
    float otherLeft = other.posX - otherSprite.getScreenWidth()/2; 
    float otherRight = other.posX + otherSprite.getScreenWidth()/2;
    float otherTop = other.posY - otherSprite.getScreenHeight()/2;
    float otherBottom = other.posY + otherSprite.getScreenHeight()/2;
    
    if(left > otherRight || right < otherLeft || top > otherBottom || bottom < otherTop) {
      overlap = false;
    }
    
    return overlap;
  }
  //tag for logic
  public void setTag(String s) {
     this.tag = s; 
  }
  //receive current tag
  public String getTag() {
     return this.tag; 
  }
  //let state register itself
  public void setGameState(GameState state) {
     this.gameState = state; 
  }
  //every go may register children on gamestate
  protected void spawn(GameObject go) {
     if(this.gameState != null) {
        this.gameState.spawn(go); 
     }
     else {
       throw new UnsupportedOperationException("No Gamestate found on GameObject!"); 
     }
  }
  protected void destroy(GameObject go) {
     if(this.gameState != null) {
        this.gameState.destroy(go); 
     }
     else {
       throw new UnsupportedOperationException("No Gamestate found on GameObject!"); 
     }
  }
}