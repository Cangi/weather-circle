
import java.util.List;
import net.aksingh.owmjapis.CurrentWeather;
import net.aksingh.owmjapis.OpenWeatherMap;
import processing.core.PApplet;
import twitter4j.Query;
import twitter4j.QueryResult;
import twitter4j.Status;
import twitter4j.Twitter;
import twitter4j.TwitterFactory;
import twitter4j.conf.ConfigurationBuilder;

public class Weather extends PApplet {

    Twitter twitter;
    String searchString = "#suceava";
    List<Status> tweets;
    int currentTweet;
    String[] lines;

    @Override
    public void setup() {

        lines = loadStrings("lib/secret.txt");

        ConfigurationBuilder configurationBuilder = new ConfigurationBuilder();
        configurationBuilder.setOAuthConsumerKey(lines[0]);
        configurationBuilder.setOAuthConsumerSecret(lines[1]);
        configurationBuilder.setOAuthAccessToken(lines[2]);
        configurationBuilder.setOAuthAccessTokenSecret(lines[3]);

        TwitterFactory twitterFactory = new TwitterFactory(configurationBuilder.build());

        twitter = twitterFactory.getInstance();
        getNewTweets();
        currentTweet = 0;
        thread("refreshTweets");
    }

    @Override
    public void settings() {
        size(800, 800);
    }

    @Override
    public void draw() {
        fill(0);
        rect(0, 0, width, height);
        currentTweet++;

        if (currentTweet >= tweets.size()) {
            currentTweet = 0;
        }

        Status status = tweets.get(currentTweet);

        fill(255);

        String formattedData = status.getUser().getName() + " @" + status.getUser().getScreenName() + "\n" + status.getText();
        text(formattedData, width / 2 - (600 / 2), height / 2, 600, 200);
        delay(3500);

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

    private void tweet() {
        try {
            // declaring object of "OpenWeatherMap" class
            OpenWeatherMap owm = new OpenWeatherMap("");

            CurrentWeather cwd = owm.currentWeatherByCityName("London");

            if (cwd.isValid()) {

                if (cwd.hasCityName()) {

                    System.out.println("City: " + cwd.getCityName());
                }

                if (cwd.getMainInstance().hasMaxTemperature() && cwd.getMainInstance().hasMinTemperature()) {

                    System.out.println("Temperature: " + cwd.getMainInstance().getMaxTemperature()
                            + "/" + cwd.getMainInstance().getMinTemperature() + "\'F");
                }
            }

            /*String newStatus = "The temperature in " + currentWeather.getCityName() + "at " + hour() + ":" + minute() + ":" + second() + " is";
             newStatus += "\n" + currentWeather.getMainInstance().getTemperature();
             Status status = twitter.updateStatus("");
             System.out.println("twweted the time and temp");*/
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
    }

    @Override
    public void keyPressed() {
        tweet();
    }
}
