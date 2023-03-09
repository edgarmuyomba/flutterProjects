import 'package:flutter/material.dart';
import 'package:pantry_pal/utils.dart';
import 'models.dart';
import 'package:pantry_pal/main.dart';
import 'package:provider/provider.dart';

class receipePage extends StatefulWidget {
  final receipe receipeDetail;
  const receipePage({super.key, required this.receipeDetail});

  @override
  State<receipePage> createState() => _receipePageState();
}

class _receipePageState extends State<receipePage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<pantryPalState>();
    List<receipe> favourites = appState.favourites;

    return Scaffold(
        appBar: AppBar(
          title:
              Text(widget.receipeDetail.title, style: TextStyle(fontSize: 16)),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_outlined),
          ),
          actions: [
            IconButton(
              onPressed: () => favourites.contains(widget.receipeDetail) ? appState.removeFavourites(widget.receipeDetail) : appState.addFavourites(widget.receipeDetail), 
              icon: favourites.contains(widget.receipeDetail) ? Icon(Icons.favorite) : Icon(Icons.favorite_border_outlined),
              color: favourites.contains(widget.receipeDetail) ? Colors.red : Colors.white,
              )
          ],
        ),
        body: Center(
            child: Column(children: [
              SizedBox(
                height: 20
              ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '*Missed Ingredients',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                  ),
                  ),
              ],
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: widget.receipeDetail.missedIngredients.length,
              itemBuilder: (BuildContext context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.receipeDetail.missedIngredients[index].name),
                );
              }),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Instructions',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                  )
                  ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: getInstructions(widget.receipeDetail.id),
                builder: (BuildContext context,
                    AsyncSnapshot<instructions> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.steps.length,
                          itemBuilder: (BuildContext context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                  (index + 1).toString() + '. ' + snapshot.data!.steps[index]),
                            );
                          });
                    } else {
                      return Center(
                        child: Text('Receipe Instructions currently unavailable')
                      );
                    }
                  } else {
                    return Center();
                  }
                }),
          )
        ])));
  }
}
