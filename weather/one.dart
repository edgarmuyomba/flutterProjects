import 'package:http/http.dart' as http;
import 'dart:convert';

// icon url - "http://openweathermap.org/img/w/" + iconcode + ".png"
//api url - http://api.openweathermap.org/data/2.5/forecast?q={cityName}&appid=047f8110fe6519e1f7ed701d95b7bbd0
// geocoding url - http://api.openweathermap.org/geo/1.0/reverse?lat=51.5098&lon=-0.1180&limit=2&appid=047f8110fe6519e1f7ed701d95b7bbd0

Future<weatherData> fetchData(city) async {
  final response = await http.get(Uri.parse(
      'http://api.openweathermap.org/data/2.5/forecast?q=' +
          city +
          '&appid=047f8110fe6519e1f7ed701d95b7bbd0'));

  if (response.statusCode == 200) {
    return weatherData.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Data!');
  }
}

class weatherData {
  final String city;
  final String country;
  final List forecasts;

  const weatherData(
      {required this.city, required this.country, required this.forecasts});

  factory weatherData.fromJson(Map<String, dynamic> json) {
    return weatherData(
        city: json['city']['name'],
        country: json['city']['country'],
        forecasts: json['list']);
  }
}

void main() {
  Future<weatherData> Kampala = fetchData('kampala');
  Kampala.then((value) {
    print(value.city);
    print(value.country);
    print(value.forecasts[0]['weather'][0]['icon']);
  });
}
