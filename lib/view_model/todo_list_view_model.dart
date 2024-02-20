import 'package:flutter/material.dart';
import 'package:my_first_flutter/model/task.dart';

class MyViewModel extends ChangeNotifier {
  final List<Task> _tasks = [];
  List<Task> get tasks => List.from(_tasks);

  void addTask(String id, String text) {
    _tasks.add(Task(id: id, title: text));
    notifyListeners();
  }

  void removeTask(String id) {
    if (_tasks.isNotEmpty) {
      _tasks.removeWhere((t) => t.id == id);
    }
    notifyListeners();
  }

  void clearTask() {
    _tasks.clear();
    notifyListeners();
  }
}
