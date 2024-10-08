import 'package:practice_1/features/core/data/weather_api/weather_api.dart';
import 'package:practice_1/features/core/domain/entities/search_query.dart';
import 'package:practice_1/features/core/domain/entities/search_response.dart';
import 'package:practice_1/features/core/domain/repositories/weather_repository.dart';

class WeatherApiRepository implements WeatherRepository {
  final WeatherApi _api;

  WeatherApiRepository(this._api);

  @override
  Future<SearchResponse> getWeatherByCity(CitySearchQuery query) async {
    var response = await _api.getWeatherByCity(query.city);
    return SearchResponse(response.tempC.toInt(), response.feelsLikeC.toInt(),
        response.condition);
  }

  @override
  Future<SearchResponse> getWeatherByCoords(CoordsSearchQuery query) async {
    var response = await _api.getWeatherByCoords(query.first, query.second);
    return SearchResponse(response.tempC.toInt(), response.feelsLikeC.toInt(),
        response.condition);
  }
}
