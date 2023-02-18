import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double age = 1;
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (_index) {
      case 0:
        page = Imperial();
        break;
      case 1:
        page = Metric();
        break;
      default:
        throw UnimplementedError('No page at $_index');
    }
    
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('BMI'),
            ),
            body: Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          onPressed: null,
                          child: Text('Imperial'),
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(18.0))))),
                      SizedBox(width: 10),
                      ElevatedButton(
                          onPressed: null,
                          child: Text('Metric'),
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(18.0))))),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BigCard(sign: Icons.male),
                      BigCard(sign: Icons.female),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('     Age (1 and above years)'),
                      Text(age.toString() + '   '),
                    ],
                  ),
                  Slider(
                      min: 1,
                      max: 100,
                      value: age,
                      onChanged: (value) {
                        setState(() {
                          age = value.truncateToDouble();
                        });
                      }),
                ],
              ),
            ))));
  }
}

class BigCard extends StatelessWidget {
  final IconData sign;

  const BigCard({super.key, required this.sign});

  @override
  Widget build(BuildContext context) {
    IconData sign = this.sign;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            alignment: Alignment.center,
            height: 170,
            width: 170,
            child: InkWell(
              child: Icon(
                sign,
                size: 50,
              ),
              onTap: null,
            )),
      ),
    );
  }
}
