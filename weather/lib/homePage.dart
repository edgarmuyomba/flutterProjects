import 'package:flutter/material.dart';
import 'package:weather/models.dart';
import 'package:weather/searchPage.dart';
import 'package:weather/settingsPage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:android_intent/android_intent.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:weather/models.dart';
import 'package:intl/intl.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    List days = getDays();
    return FutureBuilder(
        future: _determinePosition(),
        builder: (BuildContext context, AsyncSnapshot<weatherData> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final response = snapshot.data;
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
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        searchPage())),
                            icon: Icon(Icons.search),
                            iconSize: 40,
                          ),
                          IconButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        settingsPage())),
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
                                  response!.city,
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  response.country,
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w500),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      temperature(
                                          response.forecasts[0]['main']['temp'],
                                          2),
                                      style: TextStyle(
                                          fontSize: 45,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "\u2103",
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.cloud),
                                  Text(
                                      response.forecasts[0]['clouds']['all']
                                              .toString() +
                                          '%',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.thermostat),
                                  Text(
                                      response.forecasts[0]['main']['humidity']
                                              .toString() +
                                          '%',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              height: 45,
                              width: 120,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.wind_power_outlined),
                                  Text(
                                      response.forecasts[0]['wind']['speed']
                                              .toString() +
                                          'm/s',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
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
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              BigCard(
                                  temperature: temperature(
                                      response.forecasts[0]['main']['temp'], 0),
                                  time: time(response.forecasts[0]['dt_txt'])),
                              BigCard(
                                  temperature: temperature(
                                      response.forecasts[1]['main']['temp'], 0),
                                  time: time(response.forecasts[1]['dt_txt'])),
                              BigCard(
                                  temperature: temperature(
                                      response.forecasts[2]['main']['temp'], 0),
                                  time: time(response.forecasts[2]['dt_txt'])),
                              BigCard(
                                  temperature: temperature(
                                      response.forecasts[3]['main']['temp'], 0),
                                  time: time(response.forecasts[3]['dt_txt'])),
                              BigCard(
                                  temperature: temperature(
                                      response.forecasts[4]['main']['temp'], 0),
                                  time: time(response.forecasts[4]['dt_txt'])),
                              BigCard(
                                  temperature: temperature(
                                      response.forecasts[5]['main']['temp'], 0),
                                  time: time(response.forecasts[5]['dt_txt'])),
                              BigCard(
                                  temperature: temperature(
                                      response.forecasts[6]['main']['temp'], 0),
                                  time: time(response.forecasts[6]['dt_txt'])),
                              BigCard(
                                  temperature: temperature(
                                      response.forecasts[7]['main']['temp'], 0),
                                  time: time(response.forecasts[7]['dt_txt'])),
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
                                    days[0],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    days[1],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    days[2],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    days[3],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    days[4],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.network(iconUrl(response.forecasts[0]['weather'][0]['icon'])),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Image.network(iconUrl(response.forecasts[8]['weather'][0]['icon'])),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Image.network(iconUrl(response.forecasts[16]['weather'][0]['icon'])),
                                  SizedBox(
                                    height: 35,
                                  ),
                                  Image.network(iconUrl(response.forecasts[24]['weather'][0]['icon'])),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Image.network(iconUrl(response.forecasts[32]['weather'][0]['icon'])),
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
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        temperature(
                                            response.forecasts[0]['main']
                                                ['temp'],
                                            0),
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        "\u2103",
                                        style: TextStyle(
                                            fontSize: 9,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        temperature(
                                            response.forecasts[8]['main']
                                                ['temp'],
                                            0),
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        "\u2103",
                                        style: TextStyle(
                                            fontSize: 9,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 35,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        temperature(
                                            response.forecasts[16]['main']
                                                ['temp'],
                                            0),
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        "\u2103",
                                        style: TextStyle(
                                            fontSize: 9,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        temperature(
                                            response.forecasts[24]['main']
                                                ['temp'],
                                            0),
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        "\u2103",
                                        style: TextStyle(
                                            fontSize: 9,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 35,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        temperature(
                                            response.forecasts[32]['main']
                                                ['temp'],
                                            0),
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        "\u2103",
                                        style: TextStyle(
                                            fontSize: 9,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
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
            } else {
              return Scaffold(body: Center(child: Text('No Location Data')));
            }
          } else {
            return CircularProgressIndicator();
          }
        });
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  temperature,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Text(
                  "\u2103",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Text(time)
          ],
        ),
      ),
    );
  }
}

Future<weatherData> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    final AndroidIntent intent = AndroidIntent(
      action: 'android.settings.LOCATION_SOURCE_SETTINGS',
    );
    intent.launch();
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);

  final response = await http.get(Uri.parse(
      'http://api.openweathermap.org/data/2.5/forecast?lat=' +
          position.latitude.toString() +
          '&lon=' +
          position.longitude.toString() +
          '&appid=047f8110fe6519e1f7ed701d95b7bbd0'));
  if (response.statusCode == 200) {
    return weatherData.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Data!');
  }
}

String temperature(var kelvin, int deg) {
  double temp = kelvin - 272.15;
  String Temp = temp.toStringAsFixed(deg);
  return Temp;
}

String time(var clock) {
  List timelist = clock.split(' ');
  clock = timelist[1].split(':');
  clock = clock[0];
  if (int.parse(clock) >= 12) {
    clock = clock + 'pm';
  } else {
    clock = clock + 'am';
  }
  if (clock == '00am') {
    clock = '12am';
  }
  return clock;
}

List getDays() {
  List days = [];
  var now = DateTime.now();
  var formatter = DateFormat('EEEE');
  var today = formatter.format(now);
  days.add(today);
  for (var i = 1; i <= 4; i++) {
    var nextDay = now.add(Duration(days: i));
    var dayOfWeek = formatter.format(nextDay);
    days.add(dayOfWeek);
  }
  return days;
}

String iconUrl(String data) {
  String icon_url =
      'http://openweathermap.org/img/w/' + data.toString() + '.png';
  return icon_url;
}
