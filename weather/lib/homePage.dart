import 'package:flutter/material.dart';
import 'package:weather/searchPage.dart';
import 'package:weather/settingsPage.dart';

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
        child: Column(
          children: [
            SizedBox(
              height: 70,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => searchPage())),
                  icon: Icon(Icons.search),
                  iconSize: 40,
                ),
                IconButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => settingsPage())),
                  icon: Icon(Icons.segment_outlined),
                  iconSize: 40,
                )
              ],
            ),
            SizedBox(
              height: 30,
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
                            fontSize: 30, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '13C',
                        style: TextStyle(
                            fontSize: 45, fontWeight: FontWeight.bold),
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
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500)),
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
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500)),
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
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500)),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Today",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    BigCard(temperature: '12C', time: '6am'),
                    BigCard(temperature: '15C', time: '9am'),
                    BigCard(temperature: '20C', time: '12pm'),
                    BigCard(temperature: '25C', time: '3pm'),
                    BigCard(temperature: '30C', time: '6pm'),
                    BigCard(temperature: '35C', time: '9pm'),
                  ],
                )),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 23, right: 23),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Monday',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Tuesday',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Wednesday',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Thursday',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Friday',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Saturday',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Sunday',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.cloud),
                        SizedBox(
                          height: 35,
                        ),
                        Icon(Icons.cloud),
                        SizedBox(
                          height: 30,
                        ),
                        Icon(Icons.cloud),
                        SizedBox(
                          height: 35,
                        ),
                        Icon(Icons.cloud),
                        SizedBox(
                          height: 30,
                        ),
                        Icon(Icons.cloud),
                        SizedBox(
                          height: 35,
                        ),
                        Icon(Icons.cloud),
                        SizedBox(
                          height: 30,
                        ),
                        Icon(Icons.cloud),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '13c',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          '13c',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        Text(
                          '13c',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          '13c',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        Text(
                          '13c',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          '13c',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        Text(
                          '13c',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    )
                  ]),
            ),
          ],
        ),
      )),
    );
  }
}

class BigCard extends StatelessWidget {
  final String temperature;
  final String time;

  const BigCard({
    super.key,
    required this.temperature,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      margin: EdgeInsets.all(7),
      child: Container(
        alignment: Alignment.center,
        height: 100,
        width: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              temperature,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Text(time)
          ],
        ),
      ),
    );
  }
}
