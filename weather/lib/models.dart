import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter/material.dart';

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
      forecasts: json['list'],
    );
  }
}

Widget loading() {
  return LoadingAnimationWidget.staggeredDotsWave(
    color: Colors.black, 
    size: 50
    );
}
