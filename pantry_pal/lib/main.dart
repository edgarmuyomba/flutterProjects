import 'package:flutter/material.dart';
import 'homePage.dart';

void main() {
  runApp(const pantryPal());
}

class pantryPal extends StatefulWidget {
  const pantryPal({super.key});

  @override
  State<pantryPal> createState() => _pantryPalState();
}

class _pantryPalState extends State<pantryPal> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.indigo[900],
        accentColor: Colors.deepOrange
      ),
      home: homePage(),
    );
  }
}
