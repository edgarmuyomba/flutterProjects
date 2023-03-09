import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pantry_pal/main.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'models.dart';

class bigCard extends StatelessWidget {
  final int id;
  final String title;
  final String image;
  final int likes;

  const bigCard(
      {super.key,
      required this.id,
      required this.title,
      required this.image,
      required this.likes});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<pantryPalState>();
    List<int> favourites = appState.favourites;

    return Card(
        child: Container(
            height: 280,
            width: 100,
            decoration: BoxDecoration(
                image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.4), BlendMode.darken),
                    image: NetworkImage(image),
                    fit: BoxFit.cover)),
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 19,
                            color: Colors.white)),
                  ],
                ),
                SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () => favourites.contains(id) ? appState.removeFavourites(id) : appState.addFavourites(id),
                        icon: favourites.contains(id) ? Icon(Icons.favorite) : Icon(Icons.favorite_border_outlined),
                        color: favourites.contains(id) ? Colors.red : Colors.white,
                      ),
                      Text(
                        favourites.contains(id) ? (likes + 1).toString() : likes.toString(),
                          style: TextStyle(color: Colors.white)
                          ),
                    ],
                  ),
                )
              ],
            )));
  }
}

Future<receipes> getReceipes(String attached) async {
  //function to get receipes that fit particular ingredients
  final response = await http.get(Uri.parse(
      'https://api.spoonacular.com/recipes/findByIngredients?ingredients=apples,+' +
          attached +
          '&number=10&ranking=1&ignorePantry=false&apiKey=a22788893f79434f8852f9589d773ce2'));
  if (response.statusCode == 200) {
    return receipes.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load receipes!');
  }
}

Future<ingredients> getIngredients(int id) async {
  //function to get the ingredients and amounts for a particular receipe
  final response = await http.get(Uri.parse(
      'https://api.spoonacular.com/recipes/' +
          id.toString() +
          '/ingredientWidget.json?apiKey=a22788893f79434f8852f9589d773ce2'));
  if (response.statusCode == 200) {
    return ingredients.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load receipe ingredients');
  }
}

Future<instructions> getInstructions(int id) async {
  //function to get the analyzed instructions for  a receipe
  final response = await http.get(Uri.parse(
      'https://api.spoonacular.com/recipes/' +
          id.toString() +
          '/analyzedInstructions?apiKey=a22788893f79434f8852f9589d773ce2'));
  if (response.statusCode == 200) {
    try {
      return instructions.fromJson(jsonDecode(response.body));
    } on RangeError catch (e) {
      throw Exception(e);
    }
  } else {
    throw Exception('Failed to load receipe instructions');
  }
}