class weatherData {
  final String city;
  final String country;
  final double temp;

  const weatherData(
      {required this.city,
      required this.country,
      required this.temp});

  factory weatherData.fromJson(Map<String, dynamic> json) {
    return weatherData(
        city: json['city']['name'],
        country: json['city']['country'],
        temp: json['list'][0]['main']['temp'],);
  }
}