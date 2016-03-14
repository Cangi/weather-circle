//import all the twitter libraries
import twitter4j.conf.*;
import twitter4j.*;
import twitter4j.auth.*;
import twitter4j.api.*;
import java.util.*;
//make a twitter object
Twitter twitter;
//our search string
String searchString = "#love";
//a list of type status from the API
List<Status> tweets;
//the current tweet
int currentTweet;
//lines from our text file
String [] lines;
boolean notStopped = true;
void setup()
{
 size(800,200);

 //setup an array to hold every line of the text file
 lines = loadStrings("secrets.txt");

 //sets up each line of the text file to the corresponding key
 ConfigurationBuilder cb = new ConfigurationBuilder();
 cb.setOAuthConsumerKey(lines[0]);
 cb.setOAuthConsumerSecret(lines[1]);
 cb.setOAuthAccessToken(lines[2]);
 cb.setOAuthAccessTokenSecret(lines[3]);
 TwitterFactory factory = new TwitterFactory(cb.build());
 twitter = factory.getInstance();
 //call the get new tweets method
 getNewTweets();
 currentTweet = 0;
 thread("refreshTweets");
}
void draw()
{
  if(notStopped) {
     fill(0);
     rect(0, 0, width, height);
     currentTweet++;
     if (currentTweet >= tweets.size())
     {
     currentTweet = 0;
     }
     //get the object relating to the whole status,
    //including the text, the user, who the user replied to, date etc
     Status status = tweets.get(currentTweet);
     fill(255);
    
     //make a formatted string, using the real name of the user,
    //their twitter username and the text from the tweet itself
    String formattedData = status.getUser().getName() + " @" + status.getUser().getScreenName() + "\n" +
    status.getText();
    
     //draw it to the screen in the center of the screen, constrain the width of the text box to 600 pizels
     text(formattedData, width/2 - (600/2), height/2, 600, 200);
     //delay before we get the next loop, so the tweet stays on the screen for a while longer
     delay(1000);
  }
}
//gets the new tweets
void getNewTweets()
{
 //try the search
 if(notStopped) {
 try
 {
 Query query = new Query(searchString);
 //get the last 50 tweets
 query.count(50);
 QueryResult result = twitter.search(query);
 tweets = result.getTweets();
 }
 //if there is an error then catch it and print it out
 catch (TwitterException te)
 {
 System.out.println("Failed to search tweets: " + te.getMessage());
 System.exit(-1);
 }
 }
}
void refreshTweets()
{
 while (true)
 {
   if(notStopped) {
 getNewTweets();
 delay(1000);
   }
 }
}
void keyPressed()
{
  if(key=='p') {
    notStopped = !notStopped;
    delay(3000);
  }
}
