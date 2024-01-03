import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_list/components/dialogBox.dart';
import 'package:to_do_list/components/todo_tile.dart';
import 'package:to_do_list/data/database.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _Mybox = Hive.box('Mybox');
  final _controller = TextEditingController();
  ToDODataBase db = ToDODataBase();

  @override
  void initState() {
    if (_Mybox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    // TODO: implement initState
    super.initState();
  }

  bool? value;
  void checkBoxChanged(value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
          initialTask: null,
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  void editTask(int index) {
    _controller.text = db.toDoList[index][0];
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          initialTask: db.toDoList[index][0],
          onSave: () {
            setState(() {
              db.toDoList[index][0] = _controller.text;
            });

            Navigator.of(context).pop();
            db.updateDataBase();
          },
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 40, 38, 38),
        title: const Text(
          'To do',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
        backgroundColor: const Color.fromARGB(255, 79, 76, 76),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (vlaue) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
            editFunction: (context) => editTask(index),
          );
        },
      ),
    );
  }
}
