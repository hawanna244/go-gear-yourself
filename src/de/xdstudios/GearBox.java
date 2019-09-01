package de.xdstudios;

public class GearBox {
    final private int maxGears = 6;
    final private float throttleFactor = 6f;

    public boolean throttle; //gibt gas

    public int revolutionsSpeed = 0;

    private float clutchFactor = 1.0f; // wie haut die kupplung rein

    public boolean clutchePushed = false;

    public double torque;// der ausschlaggebende wert

    private int currentGear = 0; // 0 ~neutral

    public void shiftUp() {
        if (currentGear < this.maxGears) currentGear++;
    }

    public void shiftDown() {
        if (currentGear > 1) currentGear--;
    }

    public void couple() {
        clutchePushed = true;
    }

    public void decouple() {
        clutchePushed = false;
    }

    public void update(){
        float nextClutchFactor = 0;
        if (clutchePushed){
            //wie start flaellt die leistung beim kuppeln ab?
            nextClutchFactor = (clutchFactor/100)*20; //20%iger abfall
        }else {
            nextClutchFactor = clutchFactor + (clutchFactor/100)*20; //20%iger anstieg
        }
        clutchFactor = Tools.app.constrain(nextClutchFactor, 0.0f, 1.0f);

        if(throttle){
            revolutionsSpeed += (int) clutchFactor * throttleFactor;
        }

        torque = (revolutionsSpeed * (currentGear *.5));
    }

}
