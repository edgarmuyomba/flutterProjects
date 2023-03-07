import 'package:flutter/material.dart';
import 'package:pantry_pal/receipeDetails.dart';
import 'models.dart';
import 'utils.dart';

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
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
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
                          return GestureDetector(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => receipePage(receipeDetail: snapshot.data!.procedures[index]))),
                            child: bigCard(
                                title: snapshot.data!.procedures[index].title,
                                image: snapshot.data!.procedures[index].image,
                                likes: snapshot.data!.procedures[index].likes),
                          );
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