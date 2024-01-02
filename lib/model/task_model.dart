class TaskModel {
  final String title;
  final String time;
  final String date;
  final TaskStatus status;
  TaskModel({
    required this.title,
    required this.time,
    required this.date,
    this.status = TaskStatus.newTask,
  });

  Map<String, Object?> toJson() {
    return {
      "title": title,
      "status": status.name,
      "time": date,
      "date": time,
    };
  }
}

enum TaskStatus { newTask, archivedTask, doneTask }
