class Tasks {
  String id;
  List<String> taskList;

  Tasks({
    required this.id,
    required this.taskList,
  });

  factory Tasks.fromJson(Map<String, dynamic> json) => Tasks(
      id: json["id"],
      taskList: (json["taskList"] as List).map((e) => e.toString()).toList());

  Map<String, dynamic> toJson() => {
        "id": id,
        "taskList": taskList,
      };
}
