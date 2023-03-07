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
    int i = json[0]['steps'].length;
    List temp = [];
    for (int j = 0; j < i; j++) {
      temp.add(json[0]['steps'][j]['step']);
    }
    return instructions(steps: temp);
  }
}
