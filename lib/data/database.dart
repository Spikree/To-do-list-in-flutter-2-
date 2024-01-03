import 'package:hive_flutter/hive_flutter.dart';

class ToDODataBase {
  List toDoList = [];
  final _myBox = Hive.box('Mybox');

  void createInitialData() {
    toDoList = [
      ["Swipe right to edit", false],
      ["swipe left to delete", false]
    ];
  }

  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  void updateDataBase() {
    _myBox.put("TODOLIST", toDoList);
  }
}
