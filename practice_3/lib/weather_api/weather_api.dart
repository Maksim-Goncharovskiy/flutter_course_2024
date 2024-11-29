import 'dart:convert';
import 'package:http/http.dart' as http;

const String url = 'http://api.weatherapi.com/v1/current.json';
const String apiKey="<Enter your API Key here>";


class Weather {
  final double tempC;
  final double feelsLikeC;

  final String condition;

  final dynamic icon;

  const Weather(this.tempC, this.feelsLikeC, this.condition, this.icon);
}


Future<Weather> getWeather(String city) async {
  var response = await http.get(Uri.parse('$url?&q=$city&key=$apiKey'));

  if (response.statusCode == 200){
    var rJson = jsonDecode(response.body);

    return Weather(rJson['current']['temp_c'], rJson['current']['feelslike_c'], rJson['current']['condition']['text'], rJson['current']['condition']['icon']);
  }

  else {
    throw Exception("City was not found.");
  }
  
}
