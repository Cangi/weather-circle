
import processing.core.PApplet;

public class Weather extends PApplet {

    @Override
    public void setup() {
        stroke(155, 0, 0);
    }

    @Override
    public void settings() {
        size(200, 200);
    }

    @Override
    public void draw() {
        rect(mouseX, mouseY, 20, 20);
    }
}
