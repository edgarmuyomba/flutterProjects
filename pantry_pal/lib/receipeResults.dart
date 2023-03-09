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
        title: Text('Pantry Pal'),
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
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          receipePage(
                                              receipeDetail: snapshot
                                                  .data!.procedures[index]))),
                              child: bigCard(
                                receipeDetail: snapshot.data!.procedures[index],
                              ));
                        }),
                  ));
                } else {
                  return Center(child: Text("Receipe's currently unavailable"));
                }
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
