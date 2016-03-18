
import java.util.logging.Level;
import java.util.logging.Logger;
import processing.core.PApplet;
import processing.serial.*;
import java.io.IOException;
import java.util.List;
import net.aksingh.owmjapis.CurrentWeather;
import net.aksingh.owmjapis.OpenWeatherMap;
import twitter4j.Query;
import twitter4j.QueryResult;
import twitter4j.Status;
import twitter4j.Twitter;

public class Test extends PApplet {

    private Serial serialPort;

    int gx = 15;
    int gy = 35;
    int spos = 90;

    float leftColor = (float) 0.0;
    float rightColor = (float) 0.0;
    
    private Twitter twitter;
    private List<Status> tweets;
    private String searchString;

    public void initSerialConnection() {
        serialPort = new Serial(this, "COM3", 9600);
    }

    
    private void getNewTweets() {
        try {
            Query query = new Query(searchString);
            query.count(50);
            QueryResult queryResult = twitter.search(query);
            tweets = queryResult.getTweets();

        } catch (Exception e) {
            System.err.println(e.getMessage());
            System.exit(-1);
        }
    }

    public void refreshTweets() {
        while (true) {
            getNewTweets();
            delay(3000);
        }
    }
    
    
    @Override
    public void setup() {
        //initSerialConnection();
        colorMode(RGB, (float) 1.0);
        noStroke();
        rectMode(CENTER);
        frameRate(100);

        // declaring object of "OpenWeatherMap" class
        OpenWeatherMap owm = new OpenWeatherMap(OpenWeatherMap.Units.METRIC, OpenWeatherMap.Language.ROMANIAN,"");

        CurrentWeather cwd = null;
        try {
            cwd = owm.currentWeatherByCityName("Bucharest");
        } catch (IOException ex) {
            Logger.getLogger(Test.class.getName()).log(Level.SEVERE, null, ex);
        }

        if (cwd.isValid()) {

            if (cwd.hasCityName()) {

                System.out.println("City: " + cwd.getCityName());
            }

            if (cwd.getMainInstance().hasMaxTemperature() && cwd.getMainInstance().hasMinTemperature()) {

             System.out.println(cwd.getCoordInstance().getLatitude());
            }
        }

    }

    @Override
    public void settings() {
        size(640, 360);
    }

    @Override
    public void draw() {

        background((int) 0.0);
        fill(mouseX / 4);
        rect(150, 320, gx * 2, gx * 2);
        fill(180 - (mouseX / 4));
        rect(450, 320, gy * 2, gy * 2);
    }

    public static void main(String[] args) {
        Test.main("Test");
    }

}
