import 'package:flutter/material.dart';
import 'package:todo_list_firebase/model/tasks.dart';
import 'package:todo_list_firebase/repo/tasks_repo.dart';
import 'package:todo_list_firebase/view_model/user_view_model.dart';

class TasksViewModel extends ChangeNotifier {
  String? _uid;
  Tasks? _tasks;

  List<String>? get taskList => _tasks?.taskList;

  TasksViewModel(UserViewModel vm) {
    _uid = vm.user?.uid;
    if (_uid != null) {
      TasksRepo.read(_uid!).then((value) {
        _tasks = value;
        notifyListeners();
      });
    }
  }

  void addTask(String text) {
    if (_tasks == null) return;
    _tasks?.taskList.add(text);
    TasksRepo.update(_tasks!);
    notifyListeners();
  }

  void removeTask(int index) {
    if (_tasks == null) return;
    if (_tasks!.taskList.isNotEmpty) {
      _tasks!.taskList.removeAt(index);
    }
    TasksRepo.update(_tasks!);
    notifyListeners();
  }

  void clearTask() {
    if (_tasks == null) return;
    _tasks!.taskList.clear();
    TasksRepo.update(_tasks!);
    notifyListeners();
  }
}
