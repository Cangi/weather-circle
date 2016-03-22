
import java.util.HashMap;
import net.aksingh.owmjapis.CurrentWeather;
import net.aksingh.owmjapis.OpenWeatherMap;

public class WeatherFinder {

    private final OpenWeatherMap weatherMap;
    private final int cityID;
    private CurrentWeather currentWeather;

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
        this.currentWeather = weatherMap.currentWeatherByCityCode(cityID);
    }

    public String findWeather() {
        String weather = null;

        if (currentWeather.hasMainInstance()) {
            float temperature = currentWeather.getMainInstance().getTemperature();
            if (temperature < 10) {
                weather = "sunny1";
            } else if (temperature < 25) {
                weather = "sunny2";
            } else {
                weather = "sunny3";
            }

            if (currentWeather.hasCloudsInstance()) {
                if (currentWeather.getCloudsInstance().hasPercentageOfClouds()) {
                    if (currentWeather.getCloudsInstance().getPercentageOfClouds() > 50) {
                        if (temperature < 5) {
                            weather = "cloudy1";
                        } else if (temperature < 10) {
                            weather = "cloudy2";
                        } else {
                            weather = "cloudy3";
                        }
                    }

                }
            }

            if (currentWeather.hasRainInstance()) {
                if (temperature < 5) {
                    weather = "rainy1";
                } else if (temperature < 10) {
                    weather = "rainy2";
                } else {
                    weather = "rainy3";
                }
            }

            if (currentWeather.hasSnowInstance()) {
                if (temperature < -20) {
                    weather = "snowy1";
                } else if (temperature < -10) {
                    weather = "snowy2";
                } else {
                    weather = "snowy3";
                }
            }

        }

        return weather;
    }

    public String formatWeather() {
        String weather = "";
        if (currentWeather.hasMainInstance()) {
            if (currentWeather.hasCityName()) {
                weather += "Weather in " + currentWeather.getCityName().toUpperCase();
            }
            weather += ":\n\n";

            String verdict = findWeather();
            verdict = verdict.substring(0, 1).toUpperCase() + verdict.substring(1, verdict.length() - 1);
            weather += verdict.toUpperCase() + "\n\n";

            weather += "T°: " + currentWeather.getMainInstance().getTemperature() + " °C\n";
            weather += "Min T°: " + currentWeather.getMainInstance().getMinTemperature() + " °C\n";
            weather += "Max T°: " + currentWeather.getMainInstance().getMaxTemperature() + " °C\n\n";
            if (currentWeather.hasWindInstance()) {
                weather += "Wind: " + currentWeather.getWindInstance().getWindSpeed() + " m/s\n";
            }
            //weather += "Pressure: " + currentWeather.getMainInstance().getPressure() + " hpa\n";
            weather += "Humidity: " + currentWeather.getMainInstance().getHumidity() + "%";
        }
        weather += "\n";
        return weather;
    }

}
