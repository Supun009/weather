import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/models/weaher_models.dart';
import 'package:weather/servise/weathe_servise.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //api key
  final _weatherServise = WeatherServise('your API key');
  Weather? _weather;

  //fetch weather
  _fecthWeather() async {
    //get the current city
    String cityName = await _weatherServise.getCurrentCity();

    //get weather for city
    try {
      final weather = await _weatherServise.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }

    //any errors
    catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  //weather animation
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloudy.json';
      case 'rain':
      case 'drizzer':
      case 'shower rain':
        return 'assets/rainy.json';
      case 'thunderstome':
        return 'assets/thunder.json';
      case 'clear':
      default:
        return 'assets/sunny.json';
    }
  }

  //init state
  @override
  void initState() {
    super.initState();

    //fetch weather
    _fecthWeather();
  }

  //het weather for city
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //city name
            Text(_weather?.cityName ?? "'Loading city.."),

            //animation
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

            //weaher condition
            Text(_weather?.mainCondition ?? ""),

            //temperture
            Text("${_weather?.temperature.round().toString()}°C")
          ],
        ),
      ),
    );
  }
}
