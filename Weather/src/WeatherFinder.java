
import java.util.HashMap;
import java.util.Random;
import net.aksingh.owmjapis.CurrentWeather;
import net.aksingh.owmjapis.OpenWeatherMap;

public class WeatherFinder {

    private OpenWeatherMap weatherMap;
    private int cityID;

    public static final HashMap<String, Integer> cityIDs;

    static {
        cityIDs = new HashMap<>();
        cityIDs.put("London", 2643741);
        cityIDs.put("Dundee", 2650752);
        cityIDs.put("Vilnius", 593116);

        cityIDs.put("Bucharest", 683506);
        cityIDs.put("Moscow", 524901);
        cityIDs.put("Bangkok", 1609350);

        cityIDs.put("Tokyo", 1850147);
        cityIDs.put("Sydney", 2147714);
        cityIDs.put("LA", 5368361);

        cityIDs.put("NY", 5128581);
        cityIDs.put("Paris", 2988507);
        cityIDs.put("Mexico", 3530597);
    }

    ;
    
    public WeatherFinder(String apiKey, String cityName) {
        weatherMap = new OpenWeatherMap(OpenWeatherMap.Units.METRIC, apiKey);
        this.cityID = cityIDs.getOrDefault(cityName, cityIDs.get("Dundee"));
    }

    public String findWeather() {
        String weather = null;

        CurrentWeather currentWeather = weatherMap.currentWeatherByCityCode(cityID);

        String[] haha = {"sunny", "rainy", "cloudy", "snowy"};
        Random r = new Random();
        int x = r.nextInt(4);
        weather = haha[x];

        return weather;
    }
}
