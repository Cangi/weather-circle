
import processing.core.PApplet;
import processing.serial.*;

public class Test extends PApplet {

    private Serial serialPort;

    public void initSerialConnection() {
        serialPort = new Serial(this, "COM6", 9600);
    }

    @Override
    public void setup() {
        initSerialConnection();

    }

    @Override
    public void settings() {
        size(640, 360);
    }

    @Override
    public void draw() {
        /* if (serialPort.available() > 0) {
         String input = serialPort.readStringUntil('\n');
         if (input != null) {
         input = input.trim();
         System.out.println(input);
         }
         }*/
    }

    public static void main(String[] args) {
        Test.main("Test");
    }

}
