
import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import processing.core.PApplet;
import processing.serial.Serial;
import twitter4j.Status;
import twitter4j.StatusUpdate;
import twitter4j.Twitter;
import twitter4j.TwitterFactory;
import twitter4j.conf.ConfigurationBuilder;

public class Weather extends PApplet {

    public static void main(String[] args) {
        Weather.main("Weather");
    }

    Twitter twitter;
    String[] keys;
    Serial serialPort;
    String cityArrow;

    private void initSerialConnection() {

        String serialPortName = "COM5";
        int baud = 9600;
        try {
            serialPort = new Serial(this, serialPortName, baud);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void configureTweeter() {
        ConfigurationBuilder configurationBuilder = new ConfigurationBuilder();
        configurationBuilder.setOAuthConsumerKey(keys[0]);
        configurationBuilder.setOAuthConsumerSecret(keys[1]);
        configurationBuilder.setOAuthAccessToken(keys[2]);
        configurationBuilder.setOAuthAccessTokenSecret(keys[3]);

        TwitterFactory twitterFactory = new TwitterFactory(configurationBuilder.build());
        twitter = twitterFactory.getInstance();
    }

    private String getLastCityArrow() {
        String position = null;
        BufferedReader bufferedReader = createReader("lib/position.txt");
        try {
            position = bufferedReader.readLine().trim();
            return position;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                bufferedReader.close();
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }
        return null;
    }

    private void setLastCityArrow(String position) {
        try {
            PrintWriter printWriter = new PrintWriter(new FileOutputStream("lib/position.txt"));
            printWriter.println(position);
            printWriter.flush();
            printWriter.close();
        } catch (FileNotFoundException ex) {
            ex.printStackTrace();
        }
    }

    @Override
    public void setup() {
        keys = loadStrings("lib/secret.txt");
        initSerialConnection();
        configureTweeter();
    }

    @Override
    public void settings() {
    }

    @Override
    public void draw() {
        if (serialPort.available() > 0) {
            String serialLine = serialPort.readStringUntil('\n');

            if (serialLine != null) {
                serialLine = serialLine.trim();
                if (serialLine.equals("needArrow")) {
                    if (new File("lib/position.txt").exists()) {
                        String arrow = getLastCityArrow();
                        System.out.println(arrow);
                        serialPort.write(arrow);
                    }
                }

                if (serialLine.length() > "cityArrow".length()) {
                    if ("cityArrow".equals(serialLine.substring(0, "cityArrow".length()))) {
                        cityArrow = serialLine.split(" ")[1].trim();
                        setLastCityArrow(cityArrow);
                    }
                }

                if (serialLine.length() > "selected".length()) {
                    if ("selected".equals(serialLine.substring(0, "selected".length()))) {

                        String cityName = serialLine.split(" ")[1].trim();
                        System.out.println(cityName);
                        WeatherFinder weatherFinder = new WeatherFinder(keys[4], cityName);
                        String weather = weatherFinder.findWeather();
                        sendWeather(weather);
                        String tweetMessage = weatherFinder.formatWeather();
                        System.out.println(tweetMessage.length());
                        tweet(tweetMessage, weather);
                    }
                }

                System.out.println(serialLine);
            }

        }
    }

    private void tweet(String newStatus, String weather) {
        try {
            StatusUpdate statusUpdate = new StatusUpdate(newStatus);
            statusUpdate.setMedia(new File("lib/" + weather + ".png"));
            Status status = twitter.updateStatus(statusUpdate);
            System.out.println("The following was Tweeted:\n" + "\"" + newStatus + "\"");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void sendWeather(String weather) {
        if (weather != null) {
            serialPort.write(weather);
        } else {
            System.err.println("Awch");
        }
    }
}
