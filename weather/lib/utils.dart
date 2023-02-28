import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:android_intent/android_intent.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models.dart';
import 'cities.dart';
import 'citySearch.dart';

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

Future<weatherData> determinePosition() async {
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

Future<weatherData> searchWeather(String city) async {
  final response = await http.get(Uri.parse(
      'http://api.openweathermap.org/data/2.5/forecast?q=' +
          city +
          '&appid=047f8110fe6519e1f7ed701d95b7bbd0'));
  if (response.statusCode == 200) {
    return weatherData.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Data!');
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = cities;
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var city in searchTerms) {
      if (city.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(city);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var city in searchTerms) {
      if (city.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(city);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
              title: Text(result),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => search(city: result))));
        });
  }
}
