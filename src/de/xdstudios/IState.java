package de.xdstudios;

interface IState{

    void init();
    void start();
    void draw();
    void update();
    void end();
    void spawn(GameObject go);
    void gameObjectUpdate();
    void gameObjectRender();
    boolean isActive();
    void displayLoadingState();
    void beforeInit();
    void beforeDraw();
    void afterDraw();
    void beforeUpdate();
    void afterUpdate();
    void onKeyPressed(int kc);
    void beforeEnd();
    void logic();
    void render();
    String getTitle();

    void destroy(GameObject go);

}