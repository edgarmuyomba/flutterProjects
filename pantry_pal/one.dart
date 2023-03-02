// spoonacular url - https://api.spoonacular.com/recipes/findByIngredients?ingredients=apples,+flour,+sugar&number=100&ranking=1&ignorePantry=false&apiKey=a22788893f79434f8852f9589d773ce2

import 'package:http/http.dart' as http;
import 'dart:convert';

class receipts {
  final int id;
  final String image;
  final int likes;
  final List missedIngredients;

  const receipts(
      {required this.id,
      required this.image,
      required this.likes,
      required this.missedIngredients});

  factory receipts.fromJson(List<dynamic> json) {
    return receipts(
        id: json[0]['id'],
        image: json[0]['image'],
        likes: json[0]['likes'],
        missedIngredients: json[0]['missedIngredients']);
  }
}

Future<receipts> getReceipes(List ingredients) async {
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
    return receipts.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}

void main() {
  List sample = ['apples', 'cinnamon'];
  Future<receipts> r1 = getReceipes(sample);
  r1.then((value) {
    print(value.id);
    print(value.likes);
    print(value.image);
  });
}
