import 'package:flutter/material.dart';
import 'package:weather/appTheme.dart';

class settingsPage extends StatelessWidget {
  const settingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings')
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Privacy')
          ),
          ListTile(
            title: Text('Location')
          ),
          ListTile(
            title: Text('Profile')
          ),
          ListTile(
            title: Text('Storage')
          ),
          ListTile(
            title: Text('Theme'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => appTheme())),
          ),
          ListTile(
            title: Text('Weather')
          ),
        ],
      )
    );
  }
}