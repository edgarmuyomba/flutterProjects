import 'package:flutter/material.dart';
import 'package:weather/homePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "The Weather App",
        home: Scaffold(
          body: Center(
            child: homePage(),
    )));
  }
}
