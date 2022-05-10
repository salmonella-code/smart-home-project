// ignore_for_file: avoid_print

import 'location.dart';
import 'network_helper.dart';

const apiKey = "3b98919316274070e6a57c8ec84c4112"; // use your own api key !!!
const apiUrl = "http://api.openweathermap.org/data/2.5/weather";

class WeatherServices {
  Future<dynamic> getCityWeather(String cityName) async {
    Network networkHelper =
        Network('$apiUrl?q=$cityName&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    print("latitude" + location.latitude.toString());
    print("longitude" + location.longitude.toString());

    Network networkHelper = Network(
        '$apiUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherBackground(String condition) {
    switch (condition) {
      case "Rain":
        return "https://img.icons8.com/bubbles/344/rainwater-catchment.png";
      case "Thunderstorm":
        return "hhttps://img.icons8.com/external-smashingstocks-circular-smashing-stocks/344/external-thunderstorm-weather-smashingstocks-circular-smashing-stocks.png";
      case "Drizzle":
        return "https://img.icons8.com/bubbles/344/biosand-filter.png";
      case "Snow":
        return "https://img.icons8.com/bubbles/344/snow.png";
      case "Clear":
        return "https://img.icons8.com/bubbles/344/drought.png";
      case "Clouds":
        return "https://img.icons8.com/bubbles/344/clouds.png";
      case "Atmosphere":
        return "https://img.icons8.com/bubbles/344/partly-cloudy-night.png";
      default:
        return "https://img.icons8.com/bubbles/344/cloud.png";
    }
  }
}
