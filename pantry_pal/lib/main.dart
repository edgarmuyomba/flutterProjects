import 'package:flutter/material.dart';
import 'package:pantry_pal/models.dart';
import 'homePage.dart';
import 'package:provider/provider.dart';

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
    return ChangeNotifierProvider(
      create: (context) => pantryPalState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        theme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.indigo[900],
            accentColor: Colors.deepOrange),
        home: homePage(),
      ),
    );
  }
}

class pantryPalState extends ChangeNotifier {
  List<receipe> favourites = [];

  void addFavourites(receipe current) {
    favourites.add(current);
    notifyListeners();
  }

  void removeFavourites(receipe current) {
    favourites.remove(current);
    notifyListeners();
  }
}
