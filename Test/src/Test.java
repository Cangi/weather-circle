
import processing.core.PApplet;
import processing.serial.*;

public class Test extends PApplet {

    private Serial serialPort;

    public void initSerialConnection() {
        try {
            serialPort = new Serial(this, "COM3", 9600);
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }

    }

    @Override
    public void setup() {
        initSerialConnection();
    }

    @Override
    public void settings() {

    }

    @Override
    public void draw() {
    }

    public static void main(String[] args) {
        Test.main("Test");
    }

}
