import 'package:practice_1/features/core/domain/entities/search_query.dart';
import 'package:practice_1/features/core/domain/entities/search_response.dart';
import 'package:practice_1/features/core/domain/repositories/weather_repository.dart';

class WeatherRepositoryDebug implements WeatherRepository {
  @override
  Future<SearchResponse> getWeatherByCity(CitySearchQuery query) async {
    return SearchResponse(15, 12, "It's really boiling hot outside dude.");
  }

  @override
  Future<SearchResponse> getWeatherByCoords(CoordsSearchQuery query) async {
    return SearchResponse(15, 12, "It's really boiling hot outside dude.");
  }
}
