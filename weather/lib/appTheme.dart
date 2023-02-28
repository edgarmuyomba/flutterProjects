import 'package:flutter/material.dart';
import 'package:weather/main.dart';

class appTheme extends StatelessWidget {
  const appTheme({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Theme'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context), 
          icon: Icon(Icons.arrow_back_rounded)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListTile(
            title: Text('Light Mode'),
            onTap: () => MyApp.of(context).changeTheme(ThemeMode.light),
          ),
          ListTile(
            title: Text('Dark Mode'),
            onTap: () => MyApp.of(context).changeTheme(ThemeMode.dark),
          ),
          ListTile(
            title: Text('System Settings'),
            onTap: () => MyApp.of(context).changeTheme(ThemeMode.system),
          ),
        ],
      )
    );
  }
}