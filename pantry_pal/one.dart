// receipe url - https://api.spoonacular.com/recipes/findByIngredients?ingredients=apples,+flour,+sugar&number=100&ranking=1&ignorePantry=false&apiKey=a22788893f79434f8852f9589d773ce2
// ingredients url - https://api.spoonacular.com/recipes/1003464/ingredientWidget.json?apiKey=a22788893f79434f8852f9589d773ce2

import 'package:http/http.dart' as http;
import 'dart:convert';

class receipes {
  final int id;
  final String image;
  final int likes;
  final List missedIngredients;

  const receipes(
      {required this.id,
      required this.image,
      required this.likes,
      required this.missedIngredients});

  factory receipes.fromJson(List<dynamic> json) {
    return receipes(
        id: json[0]['id'],
        image: json[0]['image'],
        likes: json[0]['likes'],
        missedIngredients: json[0]['missedIngredients']);
  }
}

class ingredient {
  final String name;
  final double value;

  const ingredient({
    required this.name,
    required this.value,
  });

  //temporary
  @override
  String toString() {
    return 'Name: $name, Value: $value';
  }
}

class ingredients {
  final List details;

  const ingredients({
    required this.details,
  });

  factory ingredients.fromJson(Map<String, dynamic> json) {
    return ingredients(
      details: json['ingredients'],
    );
  }
}

Future<receipes> getReceipes(List ingredients) async {
  //function to get the receipe from a set of ingredients
  String attach = '';
  for (int i = 0; i < ingredients.length; i++) {
    if (i == ingredients.length - 1) {
      attach += ingredients[i];
    } else {
      attach += ingredients[i] + ',+';
    }
  }
  final response = await http.get(Uri.parse(
      'https://api.spoonacular.com/recipes/findByIngredients?ingredients=' +
          attach +
          '&number=100&ranking=1&ignorePantry=false&apiKey=a22788893f79434f8852f9589d773ce2'));
  if (response.statusCode == 200) {
    return receipes.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}

Future<ingredients> getIngredients(int id) async {
  //function to get the ingredients and amounts for a particular receipe
  final response = await http.get(Uri.parse('https://api.spoonacular.com/recipes/' +
      id.toString() +
      '1003464/ingredientWidget.json?apiKey=a22788893f79434f8852f9589d773ce2'));
  if (response.statusCode == 200) {
    return ingredients.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}

void main() {
  List sample = ['apples', 'cinnamon'];
  int id = 0;
  Future<receipes> r1 = getReceipes(sample);
  r1.then((value) {
    id = value.id;
  });
  Future<ingredients> I = getIngredients(id);
  I.then((value) {
    List _details = [];
    List details = value.details;
    for (Map detail in details) {
      _details.add(ingredient(
          name: detail['name'], value: detail['amount']['metric']['value']));
    }
    print(_details);
  });
}
