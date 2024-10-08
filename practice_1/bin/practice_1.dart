import 'package:practice_1/features/core/data/debug/weather_repository_debug.dart';
import 'package:practice_1/features/core/data/weather_api/weather_repository.dart';
import 'package:practice_1/features/core/data/weather_api/weather_api.dart';
import 'package:practice_1/features/core/presentation/app.dart';

const String version = '0.0.2';
const String url = 'http://api.weatherapi.com/v1/current.json';
const String apiKey = '3c573eef0b08472c891183328240810';

void main(List<String> arguments) {
  var app = App(WeatherApiRepository(WeatherApi(url, apiKey)));

  app.run();
}
