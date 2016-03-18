
import processing.core.PApplet;
import processing.serial.Serial;
import twitter4j.Status;
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

    private void initSerialConnection() {

        String serialPortName = "";
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

    @Override
    public void setup() {
        keys = loadStrings("lib/secret.txt");
        initSerialConnection();
        //configureTweeter();
    }

    @Override
    public void settings() {
        size(800, 800);
    }

    @Override
    public void draw() {
    }

    private void tweet(String newStatus) {
        try {
            Status status = twitter.updateStatus(newStatus);
            System.out.println("The following was Tweeted:\n" + "\"" + newStatus + "\"");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
