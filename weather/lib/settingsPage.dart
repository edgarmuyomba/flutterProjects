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
      body: Column(
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
          SizedBox(
            height: 400,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(Icons.copyright_outlined),
              Text(' Edgar (2023)')
            ],
          )
        ],
      )
    );
  }
}