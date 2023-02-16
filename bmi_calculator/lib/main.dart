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
  bool male = true, female = false;
  
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

    void _toggleGender(var gender) {
      if (gender == 'male') {
        setState(() {
          male = true;
          female = false;
        });
      } else if (gender == 'female') {
        setState(() {
          male = false;
          female = true;
        });
      }
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
                          onPressed: () {
                            setState(() {
                              _index = 0;
                            });
                          },
                          child: Text('Imperial'),
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(18.0))))),
                      SizedBox(width: 10),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _index = 1;
                            });
                          },
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
                      GestureDetector(
                        onTap: () => _toggleGender('male'),
                        child: BigCard(sign: Icons.male, flag: male),
                      ),
                      GestureDetector(
                          onTap: () => _toggleGender('female'),
                          child: BigCard(sign: Icons.female, flag: female)),
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
                  page,
                ],
              ),
            ))));
  }
}

class BigCard extends StatelessWidget {
  final IconData sign;
  final bool flag;

  const BigCard({super.key, required this.sign, required this.flag});

  @override
  Widget build(BuildContext context) {
    IconData sign = this.sign;
    return Card(
      color: flag ? Colors.grey[800] : Colors.grey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.center,
            height: 170,
            width: 170,
            child: Icon(
              sign,
              size: 50,
            ),
          )),
    );
  }
}

class Imperial extends StatelessWidget {
  const Imperial({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Form(
        key: _formKey,
        child: Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: 'ft'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a value';
                          }
                          return null;
                        },
                        onSaved: (value) {},
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: 'In'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a value';
                          }
                          return null;
                        },
                        onSaved: (value) {},
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'lbs'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                    onSaved: (value) {},
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class Metric extends StatelessWidget {
  const Metric({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'cm'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a value';
                  }
                  return null;
                },
                onSaved: (value) {},
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'kg'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a value';
                  }
                  return null;
                },
                onSaved: (value) {},
              ),
            ],
          ),
        ));
  }
}
