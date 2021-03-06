import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/utilities/constants.dart';

class WeatherModel {
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }

  Future getLocationData() async {
    Location location = Location();
    await location.getCurrentLocation();

    print('lat - ${location.latitude}');
    print('lng - ${location.longitude}');

    NetworkHelper networkHelper = NetworkHelper(
        url:
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&units=metric&appid=$weatherAPIKey');
    return await networkHelper.getWeatherData();
  }

  Future getCityWeather(String cityName) async {
    NetworkHelper networkHelper =  NetworkHelper(url: 'https://api.openweathermap.org/data/2.5/weather?q=$cityName&units=metric&appid=$weatherAPIKey');
    return await networkHelper.getWeatherData();
  }
}
