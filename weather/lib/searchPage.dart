import 'package:flutter/material.dart';

class searchPage extends StatefulWidget {
  const searchPage({super.key});

  @override
  State<searchPage> createState() => _searchPageState();
}

class _searchPageState extends State<searchPage> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    String _location;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('Search for a location'),
      ),
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, 
          children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: 'Search for a location',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0)),
                  prefixIcon: Icon(Icons.search),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0))),
              validator: (value) {
                if (value!.length == 0) {
                  return 'Please enter a location';
                } else {
                  return null;
                }
              },
              onSaved: (value) {
                _location = value.toString();
              },
            ),
          ),
        )
      ])),
    );
  }
}

