import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';

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
        debugShowCheckedModeBanner: false,
        title: 'BMI calculator',
        home: Scaffold(
          resizeToAvoidBottomInset: false,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Designed in pain '),
                      Icon(Icons.heart_broken),
                      Text(' by Edgar!'),
                    ],
                  )
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
    double ft = 0.0, In = 0.0, lbs = 0.0;

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
                        onSaved: (value) {
                          if (value!.length > 0) {
                            ft = double.parse(value);
                          }
                        },
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
                        onSaved: (value) {
                          if (value!.length > 0) {
                            In = double.parse(value);
                          }
                        },
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
                    onSaved: (value) {
                      if (value!.length > 0) {
                        lbs = double.parse(value);
                      }
                    },
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      double bmi = BMI(ft: ft, In: In, lbs: lbs);
                      bmiDialog(bmi, context);
                    }
                  },
                  child: Text('Calculate BMI')),
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
    double cm = 0.0, kg = 0.0;

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
                onSaved: (value) {
                  if (value!.length > 0) {
                    cm = double.parse(value);
                  }
                },
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
                onSaved: (value) {
                  if (value!.length > 0) {
                    kg = double.parse(value);
                  }
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      double bmi = BMI(kg: kg, cm: cm);
                      bmiDialog(bmi, context);
                    }
                  },
                  child: Text('Calculate BMI')),
            ],
          ),
        ));
  }
}

double BMI(
    {double ft = 0.0,
    double In = 0.0,
    double lbs = 0.0,
    double cm = 0.0,
    double kg = 0.0}) {
  if (ft > 0) {
    //imperial measurements used
    double height = (ft * 0.3048) + (In * 0.0254);
    double weight = (lbs * 0.45359237);
    double bmi = weight / (height * height);
    return bmi;
  } else {
    //metric measurements used
    double height = cm / 100;
    double bmi = kg / (height * height);
    return bmi;
  }
}

Future bmiDialog(double bmi, context) async {
  String category;
  if (bmi < 18.5) {
    category = 'Underweight';
  } else if (bmi >= 18.5 && bmi <= 24.9) {
    category = 'Normal Weight';
  } else if (bmi > 24.9 && bmi <= 29.9) {
    category = 'Overweight';
  } else {
    category = 'Obese';
  }
  await showPlatformDialog(
      context: context,
      builder: (context) => BasicDialogAlert(
            title: Text(category),
            content: Card(
                child: Container(
                  alignment: Alignment.center,
              height: 110,
              width: 110,
              child: Text(
                bmi.toStringAsFixed(1),
                style: TextStyle(fontSize: 50),
                ),
            )),
            actions: [
              BasicDialogAction(
                title: Text('Ok'),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ));
}
