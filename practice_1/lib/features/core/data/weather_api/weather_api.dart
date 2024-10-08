import 'dart:convert';

import 'package:http/http.dart' as http;
import 'models/weather_response.dart';

class WeatherApi {
  final String url;
  final String apiKey;

  WeatherApi(this.url, this.apiKey);

  Future<Weather> getWeatherByCity(String city) async {
    var response = await http.get(Uri.parse('$url?q=$city&key=$apiKey'));
    var rJson = jsonDecode(response.body);

    return Weather(rJson['current']['temp_c'], rJson['current']['feelslike_c'],
        rJson['current']['condition']['text']);
  }

  Future<Weather> getWeatherByCoords(double first, double second) async {
    var response =
        await http.get(Uri.parse('$url?q=$first,$second&key=$apiKey'));
    var rJson = jsonDecode(response.body);

    return Weather(rJson['current']['temp_c'], rJson['current']['feelslike_c'],
        rJson['current']['condition']['text']);
  }
}
