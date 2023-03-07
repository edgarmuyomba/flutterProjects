import 'package:flutter/material.dart';
import 'package:pantry_pal/utils.dart';
import 'models.dart';

class receipePage extends StatefulWidget {
  final receipe receipeDetail;
  const receipePage({super.key, required this.receipeDetail});

  @override
  State<receipePage> createState() => _receipePageState();
}

class _receipePageState extends State<receipePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(children: [
      bigCard(
          title: widget.receipeDetail.title,
          image: widget.receipeDetail.image,
          likes: widget.receipeDetail.likes),
      Text('*Missed Ingredients'),
      ListView.builder(
          itemCount: widget.receipeDetail.missedIngredients.length,
          itemBuilder: (BuildContext context, index) {
            return Text(widget.receipeDetail.missedIngredients[index]);
          }),
      Text('Instructions'),
      FutureBuilder(
          future: getInstructions(widget.receipeDetail.id),
          builder:
              (BuildContext context, AsyncSnapshot<instructions> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.steps.length,
                    itemBuilder: (BuildContext context, index) {
                      return Text('$index. ' + snapshot.data!.steps[index]);
                    });
              } else {
                throw Exception('Failed to load instructions');
              }
            } else {
              return CircularProgressIndicator();
            }
          })
    ])));
  }
}
