import 'package:flutter/material.dart';
import 'receipeResults.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String attached;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Enter your ingredients',
              suffixIcon: Icon(Icons.search),
            ),
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
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => receipeResults(attached: attached)));
              }
            },
          )
        ],
      ),
    )));
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
