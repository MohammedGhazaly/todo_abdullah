import 'package:enum_to_string/enum_to_string.dart';

class TaskModel {
  final int? id;
  final String title;
  final String time;
  final String date;
  TaskStatus status;
  TaskModel(
      {required this.title,
      required this.time,
      required this.date,
      this.status = TaskStatus.newTask,
      this.id});

  Map<String, Object?> toJson() {
    return {
      "title": title,
      "status": status,
      "time": date,
      "date": time,
    };
  }

  factory TaskModel.fromJson(Map<String, Object?> json) {
    return TaskModel(
        title: json["title"].toString(),
        time: json["date"].toString(),
        date: json["time"].toString(),
        status: EnumToString.fromString(
            TaskStatus.values, json["status"] as String)!,
        id: json["id"] as int);
  }
}

enum TaskStatus { newTask, archivedTask, doneTask }
