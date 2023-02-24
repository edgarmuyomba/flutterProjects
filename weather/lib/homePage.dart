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
          child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            BigCard(location: 'Kampala'),
            BigCard(location: 'Kampala'),
            BigCard(location: 'Kampala'),
            BigCard(location: 'Kampala'),
            BigCard(location: 'Kampala'),
          ],
        ),
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25)
      ),
      margin: EdgeInsets.all(7),
      child: Container(
        height: 200,
        width: 200,
        child: Text(location),
      ),
    );
  }
}
