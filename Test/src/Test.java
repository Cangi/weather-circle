
import processing.core.PApplet;
import processing.serial.*;

public class Test extends PApplet {

    private Serial serialPort;

    int gx = 15;
    int gy = 35;
    int spos = 90;

    float leftColor = (float) 0.0;
    float rightColor = (float) 0.0;

    public void initSerialConnection() {
        serialPort = new Serial(this, "COM3", 9600);
    }

    @Override
    public void setup() {
        initSerialConnection();
        colorMode(RGB, (float) 1.0);
        noStroke();
        rectMode(CENTER);
        frameRate(100);
    }

    @Override
    public void settings() {
        size(640, 360);
    }

    @Override
    public void draw() {

        background((int) 0.0);
        update(mouseX);
        fill(mouseX / 4);
        rect(150, 320, gx * 2, gx * 2);
        fill(180 - (mouseX / 4));
        rect(450, 320, gy * 2, gy * 2);
    }

    public void update(int x) {
        //Calculate servo postion from mouseX
        spos = x / 4;

        //Output the servo position ( from 0 to 180)
        serialPort.write("s" + spos);
        System.out.println("s" + spos);

        // Just some graphics
        leftColor = (float) (-0.002 * x / 2 + 0.06);
        rightColor = (float) (0.002 * x / 2 + 0.06);

        gx = x / 2;
        gy = 100 - x / 2;

    }

    public static void main(String[] args) {
        Test.main("Test");
    }

}
