class SearchResponse {
  final int tempC;
  final int feelsLikeC;
  final String condition;

  const SearchResponse(this.tempC, this.feelsLikeC, this.condition);

  @override
  String toString() {
    return 'Weather{tempC: $tempC, feelsLikeC: $feelsLikeC, condition: $condition}';
  }
}
