import 'package:flutter/material.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          SizedBox(
            height: 120,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Berlin,',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        ),
                    ),
                    Text(
                      'Germany',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500
                        ),
                    ),
                    Text(
                      '13C',
                      style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold
                        ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Container(
                  alignment: Alignment.center,
                  height: 45,
                  width: 95,
                  child: Text('6%',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Container(
                  alignment: Alignment.center,
                  height: 45,
                  width: 95,
                  child: Text('90%',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Container(
                  alignment: Alignment.center,
                  height: 45,
                  width: 95,
                  child: Text('19km/h',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                ),
              ),
            ],
          )
        ],
      )),
    );
  }
}

class BigCard extends StatelessWidget {
  final String location;

  const BigCard({
    super.key,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      margin: EdgeInsets.all(7),
      child: Container(
        height: 200,
        width: 200,
        child: Text(location),
      ),
    );
  }
}
