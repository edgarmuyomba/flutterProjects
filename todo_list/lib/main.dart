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

  void _deleteTask(Task task) {
    Tasks.remove(task);
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
    TextEditingController _description = TextEditingController();

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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Details(task: task)),
                );
              },
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
                isScrollControlled: true,
                builder: (context) {
                  return Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: this._formKey,
                        child: Row(children: [
                          Expanded(
                            child: TextFormField(
                              controller: _description,
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
                                _formKey.currentState!.reset();
                                _description.clear();
                              }
                            },
                          )
                        ]),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}

class Details extends StatefulWidget {
  final Task task;

  const Details({super.key, required this.task});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    Task task = widget.task;
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    var appState = context.watch<MyAppState>();

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back_outlined),
              onPressed: () {
                _formKey.currentState!.save();
                Navigator.pop(context);
              }),
          title: Text(task.description),
          actions: [
            IconButton(
              icon: Icon(Icons.delete_outline),
              onPressed: () {
                appState._deleteTask(task);
                Navigator.pop(context);
              },
            )
          ],
        ),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue:
                            task.details.length > 0 ? task.details : '',
                        decoration: InputDecoration(
                            labelText: 'Enter details about the task...'),
                        onSaved: (value) {
                          if (value!.length > 0) {
                            setState(() {
                              task.details = value.toString();
                            });
                          } else {
                            setState(() {
                              task.details = '';
                            });
                          }
                        },
                      ),
                    ],
                  )),
            ],
          ),
        )));
  }
}
