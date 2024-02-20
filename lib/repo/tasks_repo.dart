import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_list_firebase/model/tasks.dart';

class TasksRepo {
  static final _coll = FirebaseFirestore.instance.collection("users");

  static Future<Tasks?> read(String id) async {
    try {
      final doc = await _coll.doc(id).get();
      final data = doc.data();
      if (data == null) return null;
      return Tasks.fromJson(data);
    } on Exception {
      return null;
    }
  }

  static Future<Tasks?> create(String id) async {
    if ((await _coll.doc(id).get()).exists) return null;
    final data = Tasks(id: id, taskList: []);
    try {
      await _coll.doc(id).set(data.toJson());
      return data;
    } on Exception {
      return null;
    }
  }

  static Future<void> update(Tasks data) async {
    await _coll.doc(data.id).set(data.toJson());
  }
}
