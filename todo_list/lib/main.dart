import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        home: homePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  List<Task> Tasks = [];

  void _addTask(Task task) {
    Tasks.add(task);
    notifyListeners();
  }
}

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    List tasks = appState.Tasks;

    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo List'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          for (var task in tasks)
            ListTile(
              leading: IconButton(
                icon: task.status == 'Complete'
                    ? Icon(Icons.radio_button_checked_sharp)
                    : Icon(Icons.radio_button_off),
                onPressed: () {
                  if (task.status == 'Incomplete') {
                    setState(() {
                      task.status = 'Complete';
                    });
                  } else {
                    setState(() {
                      task.status = 'Incomplete';
                    });
                  }
                },
              ),
              title: Text(
                task.description,
                style: TextStyle(
                  decoration: task.status == 'Complete'
                      ? TextDecoration.lineThrough
                      : null,
                  decorationColor: Colors.grey[700],
                  decorationThickness: 2.0,
                ),
              ),
            )
        ],
      )),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            String description = '';
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    padding: EdgeInsets.all(16),
                    child: Form(
                      key: this._formKey,
                      child: Row(children: [
                        Expanded(
                          child: TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Description'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter a short description of the task';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              description = value.toString();
                            },
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_circle_up_rounded),
                          onPressed: () {
                            var isValid = _formKey.currentState!.validate();
                            if (isValid) {
                              _formKey.currentState!.save();
                              Task task = Task(description: description);
                              appState._addTask(task);
                            }
                          },
                        )
                      ]),
                    ),
                  );
                });
          }),
    );
  }
}
