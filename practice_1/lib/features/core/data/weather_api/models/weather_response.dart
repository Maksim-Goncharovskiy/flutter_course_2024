class Weather {
  final double tempC;
  final double feelsLikeC;

  final String condition;

  const Weather(this.tempC, this.feelsLikeC, this.condition);

  @override
  String toString() {
    return 'Weather{real_temp: $tempC, feels_like: $feelsLikeC, condition: $condition}';
  }
}
