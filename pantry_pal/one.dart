// receipe url - https://api.spoonacular.com/recipes/findByIngredients?ingredients=apples,+flour,+sugar&number=100&ranking=1&ignorePantry=false&apiKey=a22788893f79434f8852f9589d773ce2
// ingredients url - https://api.spoonacular.com/recipes/1003464/ingredientWidget.json?apiKey=a22788893f79434f8852f9589d773ce2
// instructions url - https://api.spoonacular.com/recipes/3456/analyzedInstructions?apiKey=a22788893f79434f8852f9589d773ce2

import 'package:http/http.dart' as http;
import 'dart:convert';

class receipe {
  final int id;
  final String title;
  final String image;
  final int likes;
  final List missedIngredients;

  const receipe(
      {required this.id,
      required this.title,
      required this.image,
      required this.likes,
      required this.missedIngredients});

  @override
  String toString() {
    return 'Name: $title, Image: $image, missed Ingredients: $missedIngredients';
  }
}

class missedIngredient {
  final String name;

  const missedIngredient({
    required this.name,
  });

  @override
  String toString() {
    return '$name';
  }
}

class receipes {
  final List<receipe> procedures;

  const receipes({required this.procedures});

  factory receipes.fromJson(List<dynamic> json) {
    int i = json.length;
    List<receipe> temp = [];
    for (int j = 0; j < i; j++) {
      int k = json[j]['missedIngredientCount'];
      List<missedIngredient> temp2 = [];
      for (int l = 0; l < k; l++) {
        temp2.add(missedIngredient(
          name: json[j]['missedIngredients'][l]['original'],
        ));
      }
      temp.add(receipe(
          id: json[j]['id'],
          title: json[j]['title'],
          image: json[j]['image'],
          likes: json[j]['likes'],
          missedIngredients: temp2));
    }
    return receipes(procedures: temp);
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
    List temp = [];
    int i = json['ingredients'].length;
    for (int j = 0; j < i; j++) {
      temp.add(ingredient(
          name: json['ingredients'][j]['name'],
          value: json['ingredients'][j]['amount']['metric']['value']));
    }
    return ingredients(
      details: temp,
    );
  }
}

class instructions {
  final List steps;

  const instructions({required this.steps});

  factory instructions.fromJson(List<dynamic> json) {
    return instructions(steps: json[0]['steps']);
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
    throw Exception('Failed to load receipes');
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

void main() {
  List sample = ['apples', 'flour', 'sugar'];
  int id = 0;
  Future<receipes> r1 = getReceipes(sample);
  r1.then((value) {
    receipe R = value.procedures[0];
    print('////////////////////////Ingredients////////////////////////');
    Future<ingredients> I = getIngredients(R.id);
    I.then((value) {
      print(value.details);
    });
    print('/////////////////////////Instructions//////////////////////');
    Future<instructions> II = getInstructions(R.id);
    II.then((value) {
      print(value.steps);
    });
  });
}

