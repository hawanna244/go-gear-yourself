package de.xdstudios;


import processing.core.PImage;

public class Game extends GameState {

    //MainMenu Class to provide first interaction with the game and basic information.
    //Used to start and end the game.

    private PImage player1Image, player2Image;
    GameObject player1, player2;

    public Game() {
        super("Game");
        Tools.log("Created Game!", this);
    }

    public void beforeInit() {
        Tools.log("Going into Game soon.", this);
    }

    public void beforeEnd() {
        Tools.log("Exiting Game soon.", this);
    }

    //setup the scene.
    public void start() {
        player1 = new GameObject(new Sprite(player1Image));
        this.spawn(player1);

        player2 = new GameObject(new Sprite(player2Image));
        this.spawn(player2);
        //TODO:
        //create GameObject for Menu Background

        //Create GameObject for Logo

        //create GameObject for Interaction Hint string
    }

    //Main logic of this gamestate.
    //Gets called within update cycle.
    public void logic() {

    }

    //Main render function of this gamestate.
    //Gets called within draw cycle.
    public void render() {

    }

    //function to fill a member of this class with all required ressources for the application.
    //TODO
    void loadAssets() {
        player1Image = Tools.app.loadImage("assets/img/gameobjects/player1.png");
        player2Image = Tools.app.loadImage("assets/img/gameobjects/player2.png");
    }

    //override
    public void onKeyPressed(int kc) {
        Tools.app.println("kc: " + kc);
        switch (kc) {
            case 39:
                player1.posX += 1;
            case 37:
                player1.posX -= 1;
            case 38:
                player1.posY += 1;
            case 40:
                player1.posY -= 1;

        }
    }
}
