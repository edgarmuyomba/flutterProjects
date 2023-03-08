import 'package:flutter/material.dart';

class favoritesPage extends StatefulWidget {
  const favoritesPage({super.key});

  @override
  State<favoritesPage> createState() => _favoritesPageState();
}

class _favoritesPageState extends State<favoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context), 
          icon: Icon(Icons.arrow_back),
          ),
          title: Text('Favourite Receipes'),
      ),
      body: Center()
    );
  }
}