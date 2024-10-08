import 'dart:convert';

import 'package:http/http.dart' as http;
import 'models/weather_response.dart';

class WeatherApi {
  final String url;
  final String apiKey;

  WeatherApi(this.url, this.apiKey);

  Future<Weather> getWeather(String city) async {
    var response = await http.get(Uri.parse('$url?q=$city&key=$apiKey'));
    var rJson = jsonDecode(response.body);

    return Weather(rJson['current']['temp_c'], rJson['current']['feelslike_c'],
        rJson['current']['condition']['text']);
  }
}
