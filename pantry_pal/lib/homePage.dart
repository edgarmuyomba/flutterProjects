import 'package:flutter/material.dart';
import 'package:pantry_pal/favorites.dart';
import 'receipeResults.dart';
import 'dart:math';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String attached;
  List<String> images = [
    'images/bg1.png',
    'images/bg2.png',
    'images/bg3.png',
    'images/bg4.png',
    'images/bg5.png'
  ];
  String bgImage = '';

  @override
  Widget build(BuildContext context) {
    int randIndex = Random().nextInt(images.length);
    bgImage = images[randIndex];

    return Container(
      decoration: BoxDecoration(
          image:
              DecorationImage(image: AssetImage(bgImage), fit: BoxFit.cover)),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Center(
                child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        favoritesPage())),
                            icon: Icon(
                              Icons.favorite,
                              color: Colors.white,
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 250,
                    ),
                    Column(
                      children: [
                        Text('Pantry Pal',
                            style: TextStyle(
                                fontSize: 50,
                                fontFamily: 'Satisfy',
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              labelText: 'Enter your ingredients',
                              labelStyle: TextStyle(color: Colors.white),
                              suffixIcon: Icon(Icons.search),
                              suffixIconColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ))),
                          validator: (value) {
                            if (value!.contains('and')) {
                              return 'Remove all illegal terms from the sequence of ingredients';
                            } else if (!(value.length > 0)) {
                              return 'This is a required field';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            attached = clean(value);
                          },
                        ),
                        ElevatedButton(
                          child: Text('Search'),
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(25.0)))),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          receipeResults(attached: attached)));
                            }
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )),
          )),
    );
  }
}

String clean(astring) {
  List splitted = [];
  if (astring.contains(',')) {
    splitted = astring.split(',');
  } else {
    splitted = astring.split(' ');
  }
  List finalList = [];
  for (String split in splitted) {
    finalList.add(split.trim());
  }
  String attached = finalList.join(',+');
  return attached;
}
