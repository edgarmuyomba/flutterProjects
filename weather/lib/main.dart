import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _currentPage = 0;
  var _pages = [
    Text('Home Page'),
    Text('Search Page'),
    Text('Saved'),
    Text('Profile')
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "The Weather App",
        home: Scaffold(
          body: Center(child: _pages.elementAt(_currentPage)),
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.grey,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: 'Home'
              ),
              BottomNavigationBarItem(icon: Icon(Icons.search),
              label: 'Search'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.system_update_tv_rounded),
                  label: 'Save'),
              BottomNavigationBarItem(icon: Icon(Icons.person_2_rounded), 
              label: 'Profile')
            ],
            currentIndex: _currentPage,
            fixedColor: Colors.blue,
            onTap: (int index) {
              setState(() {
                _currentPage = index;
              });
            },
          ),
        ));
  }
}
