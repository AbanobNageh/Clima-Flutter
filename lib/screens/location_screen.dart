import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  final locationWeatherData;

  LocationScreen({this.locationWeatherData});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  double temperature;
  int conditionId;
  String cityName;

  String temperatureText;
  String weatherIconText;
  String messageText;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeatherData);
  }

  void updateUI(dynamic locationWeatherData) {
    if (locationWeatherData == null) {
      temperature = 0;
      weatherIconText = "Error";
      messageText = "An error occured.";
      cityName = '';
      return;
    }

    temperature = locationWeatherData['main']['temp'];
    conditionId = locationWeatherData['weather'][0]['id'];
    cityName = locationWeatherData['name'];

    this.temperatureText = temperature.toInt().toString() + '°';
    this.weatherIconText = '${WeatherModel().getWeatherIcon(conditionId)}️';
    this.messageText =
        "${WeatherModel().getMessage(temperature.toInt())} in $cityName";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var decodedData = await WeatherModel().getLocationData();
                      setState(() {
                        updateUI(decodedData);
                      });
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CityScreen(),
                        ),
                      );

                      if (typedName != null) {
                        var decodedData = await WeatherModel().getCityWeather(typedName);
                        setState(() {
                          updateUI(decodedData);
                        });
                      }
                    },

                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      temperatureText,
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIconText,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  messageText,
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
