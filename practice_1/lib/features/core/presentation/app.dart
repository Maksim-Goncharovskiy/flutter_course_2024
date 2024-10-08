import 'package:practice_1/features/core/domain/entities/search_query.dart';
import 'package:practice_1/features/core/domain/repositories/weather_repository.dart';
import 'dart:io';

class App {
  final WeatherRepository repository;

  App(this.repository);

  void run() async {
    print("[INFO] Приложение запущено.");
    print("[INFO] Для завершения нажмите q.");

    while (true) {
      print("""Выберете способ получения погоды:
        0 - по наименованию города
        1 - по координатам""");

      var choice = stdin.readLineSync();

      if (choice == '0') {
        print("Введите город: ");

        var city = stdin.readLineSync();

        if (city == null) {
          print('Ошибка ввода. Попробуйте ещё раз.');
          continue;
        } else if (city == 'q') {
          print("Заверешение программы...");
          break;
        }

        var resp = await repository.getWeatherByCity(CitySearchQuery(city));

        print("""Погода в городе $city:
          - Температура ${resp.tempC}°С 
          - Ощущается как ${resp.feelsLikeC}°С
          - Описание: ${resp.condition}""");
      } else if (choice == '1') {
        print("Введите координаты через запятую без пробелов: ");

        var input = stdin.readLineSync();

        if (input == null) {
          print("Ошибка ввода. Попробуйте ещё раз.");
          continue;
        }
        if (input == 'q') {
          print("Заверешение программы...");
          break;
        }

        var coords = input.split(',');

        var first = double.tryParse(coords[0].trim());
        var second = double.tryParse(coords[1].trim());

        if (first == null || second == null) {
          print("Ошибка ввода. Попробуйте ещё раз.");
          continue;
        }

        var resp = await repository
            .getWeatherByCoords(CoordsSearchQuery(first, second));

        print("""Погода по координатам $coords:
          - Температура ${resp.tempC}°С 
          - Ощущается как ${resp.feelsLikeC}°С
          - Описание: ${resp.condition}""");
      } else if (choice == 'q') {
        print("Заверешение программы...");
        break;
      } else {
        print("Ошибка ввода. Попробуйте ещё раз.");
        continue;
      }
    }
  }
}
