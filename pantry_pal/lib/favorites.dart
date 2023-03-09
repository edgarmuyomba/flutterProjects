import 'package:flutter/material.dart';
import 'package:pantry_pal/main.dart';
import 'package:pantry_pal/receipeDetails.dart';
import 'package:pantry_pal/utils.dart';
import 'package:provider/provider.dart';
import 'models.dart';

class favoritesPage extends StatefulWidget {
  const favoritesPage({super.key});

  @override
  State<favoritesPage> createState() => _favoritesPageState();
}

class _favoritesPageState extends State<favoritesPage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<pantryPalState>();
    List<receipe> favourites = appState.favourites;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back),
          ),
          title: Text('Favourite Receipes'),
        ),
        body: Center(
            child: ListView.builder(
                itemCount: favourites.length,
                itemBuilder: (BuildContext context, index) {
                  return GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => receipePage(receipeDetail: favourites[index]))),
                    child: bigCard(receipeDetail: favourites[index]))
                    ;
                })));
  }
}
