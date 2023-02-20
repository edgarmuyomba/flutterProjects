import 'package:flutter/material.dart';
import 'bodmas.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String equation = '';
  String answer = '';

  void _display(String character) {
    setState(() {
      if (equation.length == 1 && character == '0') {
        null;
      } else if (equation.isEmpty && character == '+/-') {
        equation += '-';
      } else if (equation.length > 1 &&
          equation.substring(equation.length - 1, equation.length) == '.' &&
          character == '.') {
        null;
      } else if (equation.isEmpty && character == '.') {
        equation += '0.';
      } else {
        equation += character.toString();
      }
    });
  }

  void _clearDisplay() {
    setState(() {
      equation = '';
      answer = '';
    });
  }

  void _backSpace() {
    setState(() {
      equation = equation.substring(0, equation.length - 1);
    });
  }

  void _getAnswer() {
    setState(() {
      answer = bodmas(equation);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: const Text('Calculator')),
          body: Column(children: [
            SizedBox(
                height: 250,
                child: Column(children: [
                  SizedBox(
                    height: 120,
                    child: Row(
                      //the display
                      children: [
                        Expanded(
                          child: Text(
                            equation,
                            style: TextStyle(fontSize: 30),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 120,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //the answer
                          Expanded(
                            child: Text(
                              answer,
                              style: TextStyle(fontSize: 30),
                              textAlign: TextAlign.end,
                            ),
                          )
                        ]),
                  ),
                  SizedBox(
                    height: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          disabledColor: Colors.grey[600],
                          color: Colors.blue,
                          icon: Icon(
                            Icons.backspace,
                            size: 30,
                          ),
                          onPressed:
                              equation.length > 0 ? () => _backSpace() : null,
                        ),
                      ],
                    ),
                  ),
                ])),
            SizedBox(height: 30),
            Divider(
              height: 1,
              color: Colors.grey[800],
            ),
            SizedBox(height: 10),
            Expanded(
                child: GridView.count(
              padding: EdgeInsets.all(4),
              crossAxisCount: 4,
              childAspectRatio: 1,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              children: [
                GridTile(
                    child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.grey[800])),
                  child: Text('',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold)),
                  onPressed: null,
                )),
                GridTile(
                    child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.grey[800])),
                  child: Text('C',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.red[600],
                          fontWeight: FontWeight.bold)),
                  onPressed: _clearDisplay,
                )),
                GridTile(
                    child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.grey[800])),
                  child: Text('%',
                      style: TextStyle(fontSize: 25, color: Colors.blue[700])),
                  onPressed: () => _display('%'),
                )),
                GridTile(
                    child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.grey[800])),
                  child: Text('/',
                      style: TextStyle(fontSize: 25, color: Colors.blue[700])),
                  onPressed: () => _display('/'),
                )),
                GridTile(
                    child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.grey[800])),
                  child: Text('7',
                      style: TextStyle(fontSize: 25, color: Colors.blue[700])),
                  onPressed: () => _display('7'),
                )),
                GridTile(
                    child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.grey[800])),
                  child: Text('8',
                      style: TextStyle(fontSize: 25, color: Colors.blue[700])),
                  onPressed: () => _display('8'),
                )),
                GridTile(
                    child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.grey[800])),
                  child: Text('9',
                      style: TextStyle(fontSize: 25, color: Colors.blue[700])),
                  onPressed: () => _display('9'),
                )),
                GridTile(
                    child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.grey[800])),
                  child: Text('x',
                      style: TextStyle(fontSize: 25, color: Colors.blue[700])),
                  onPressed: () => _display('x'),
                )),
                GridTile(
                    child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.grey[800])),
                  child: Text('4',
                      style: TextStyle(fontSize: 25, color: Colors.blue[700])),
                  onPressed: () => _display('4'),
                )),
                GridTile(
                    child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.grey[800])),
                  child: Text('5',
                      style: TextStyle(fontSize: 25, color: Colors.blue[700])),
                  onPressed: () => _display('5'),
                )),
                GridTile(
                    child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.grey[800])),
                  child: Text('6',
                      style: TextStyle(fontSize: 25, color: Colors.blue[700])),
                  onPressed: () => _display('6'),
                )),
                GridTile(
                    child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.grey[800])),
                  child: Text('-',
                      style: TextStyle(fontSize: 25, color: Colors.blue[700])),
                  onPressed: () => _display('-'),
                )),
                GridTile(
                    child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.grey[800])),
                  child: Text('1',
                      style: TextStyle(fontSize: 25, color: Colors.blue[700])),
                  onPressed: () => _display('1'),
                )),
                GridTile(
                    child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.grey[800])),
                  child: Text('2',
                      style: TextStyle(fontSize: 25, color: Colors.blue[700])),
                  onPressed: () => _display('2'),
                )),
                GridTile(
                    child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.grey[800])),
                  child: Text('3',
                      style: TextStyle(fontSize: 25, color: Colors.blue[700])),
                  onPressed: () => _display('3'),
                )),
                GridTile(
                    child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.grey[800])),
                  child: Text('+',
                      style: TextStyle(fontSize: 25, color: Colors.blue[700])),
                  onPressed: () => _display('+'),
                )),
                GridTile(
                    child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.grey[800])),
                  child: Text('+/-',
                      style: TextStyle(fontSize: 25, color: Colors.blue[700])),
                  onPressed: () => _display('+/-'),
                )),
                GridTile(
                    child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.grey[800])),
                  child: Text('0',
                      style: TextStyle(fontSize: 25, color: Colors.blue[700])),
                  onPressed: () => _display('0'),
                )),
                GridTile(
                    child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.grey[800])),
                  child: Text('.',
                      style: TextStyle(fontSize: 25, color: Colors.blue[700])),
                  onPressed: () => _display('.'),
                )),
                GridTile(
                    child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue)),
                  child: Text('=',
                      style: TextStyle(fontSize: 25, color: Colors.white)),
                  onPressed: _getAnswer,
                )),
              ],
            ))
          ])),
    );
  }
}
