import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models.dart';

class receipeResults extends StatefulWidget {
  final String attached;
  const receipeResults({super.key, required this.attached});

  @override
  State<receipeResults> createState() => _receipeResultsState();
}

class _receipeResultsState extends State<receipeResults> {
  @override
  Widget build(BuildContext context) {
    String attached = widget.attached;
    return Scaffold(
      body: Center(
        child: FutureBuilder(
            future: getReceipes(attached),
            builder: (BuildContext context, AsyncSnapshot<receipes> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return Scaffold(
                      body: Center(
                    child: ListView.builder(
                        itemCount: snapshot.data!.procedures.length,
                        itemBuilder: (BuildContext context, int index) {
                          return bigCard(
                              title: snapshot.data!.procedures[index].title,
                              image: snapshot.data!.procedures[index].image,
                              likes: snapshot.data!.procedures[index].likes);
                        }),
                  ));
                } else {
                  throw Exception('Failed to load receipes');
                }
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}

Future<receipes> getReceipes(String attached) async {
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

class bigCard extends StatelessWidget {
  final String title;
  final String image;
  final int likes;

  const bigCard(
      {super.key,
      required this.title,
      required this.image,
      required this.likes});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
            height: 250,
            width: 100,
            decoration: BoxDecoration(
                image: DecorationImage(
                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
                    image: NetworkImage(image), fit: BoxFit.cover)
                    ),
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                        color: Colors.white
                        )
                      ),
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
                      Icon(
                        Icons.favorite_border_outlined,
                        color: Colors.white,
                        ), 
                      Text(
                        likes.toString(),
                        style: TextStyle(
                          color: Colors.white
                        )
                        ),
                        ],
                  ),
                )
              ],
            )));
  }
}
