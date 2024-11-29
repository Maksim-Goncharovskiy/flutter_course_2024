import 'package:flutter/material.dart';
import './weather_api/weather_api.dart';

void main() async {
  var resp = await getWeather("Москва");
  print("Температура воздуха: ${resp.tempC}");
  print("Ощущается как: ${resp.feelsLikeC}");
  print("Описание: ${resp.condition}");

  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}



class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _cityController = TextEditingController();
  String? _cityName;
  Weather? _weatherData;
  String? _errorMessage;


  Future<void> _getWeatherData(String cityName) async {
    setState(() {
       _cityName = cityName;
      _errorMessage = null;
      _weatherData = null;
    });

    try {
      Weather weatherData = await getWeather(cityName);
      setState(() {
        _weatherData = weatherData;
      });
    }
    catch(e){
      setState(() {
      _errorMessage = "Город не найден.";
    });
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text('Погода', style: TextStyle(color: Color.fromARGB(255, 173, 163, 228)),),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Colors.blue, Colors.purple])
        ),
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.white70),
                hintText: 'Введите название города',
                prefixIcon: IconButton(icon: const Icon(Icons.search), onPressed: (){_getWeatherData(_cityController.text);})
              ),
              onSubmitted: (value) {
                _getWeatherData(value);
              },
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 50),
            
            if (_weatherData != null)
              Card(shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)
              ),
              color: Colors.grey.withOpacity(0.1), 
              child: Padding(padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    Text('Город: $_cityName', style: const TextStyle(fontSize: 35, color: Color.fromARGB(255, 173, 163, 228))),
                    Text(
                        'Температура: ${_weatherData!.tempC}°C',
                       style: const TextStyle(fontSize: 21, color: Colors.white70)),
                    Text(
                        'Ощущается как: ${_weatherData!.feelsLikeC}°C',
                        style: const TextStyle(fontSize: 21, color: Colors.white70)),
                   Text(
                        'Условия: ${_weatherData!.condition}',
                       style: const TextStyle(fontSize: 21, color: Colors.white70)),
                    Image.network( 'http://cdn.weatherapi.com/weather/64x64/day/${_weatherData!.icon.split('/').last}')
                  ],
              ),))
              ,

            if (_errorMessage != null)
              Center(
                child: Text(
                _errorMessage!,
                style: const TextStyle(fontSize: 20, color: Color.fromARGB(255, 255, 255, 255)),
              ),
              )
          ],
        ),
      ),
    );
  }
}
  