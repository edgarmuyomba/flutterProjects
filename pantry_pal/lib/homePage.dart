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
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/bg1.jpg'),
          fit: BoxFit.cover
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
          body: Center(
              child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Pantry Pal',
                style: TextStyle(
                  fontSize: 50,
                  fontFamily: 'Satisfy',
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                )
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Enter your ingredients',
                  labelStyle: TextStyle(
                    color: Colors.white
                  ),
                  suffixIcon: Icon(Icons.search),
                  suffixIconColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                    )
                  )
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
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0)
                    )
                  )
                ),
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
        ),
      ))),
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
