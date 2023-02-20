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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var task in tasks) 
            ListTile(
              leading: IconButton(
                icon: Icon(Icons.radio_button_off,
                ),
                onPressed: null,
              ),
              title: task.description,
              subtitle: task.due,
            )
          ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context, 
            builder: (context) {
              return Container(
                padding: EdgeInsets.all(16),
                child: Form(
                  
                ),
              );
            })
        }
        ),
    );
  }
}
