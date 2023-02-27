class weatherData {
  final String city;
  final String country;
  final double lat;
  final double lon;

  const weatherData(
      {required this.city,
      required this.country,
      required this.lat,
      required this.lon});

  factory weatherData.fromJson(Map<String, dynamic> json) {
    return weatherData(
        city: json['city']['name'],
        country: json['city']['country'],
        lat: json['city']['coord']['lat'],
        lon: json['city']['coord']['lon']);
  }
}