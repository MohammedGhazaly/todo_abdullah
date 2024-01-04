import 'package:flutter/material.dart';
import 'package:to_do_abdullah/model/task_model.dart';
import 'package:to_do_abdullah/utils/local_db.dart';
import 'package:to_do_abdullah/widgets/task_widget.dart';

class NewTasksScreen extends StatefulWidget {
  const NewTasksScreen({super.key});

  @override
  State<NewTasksScreen> createState() => _NewTasksScreenState();
}

class _NewTasksScreenState extends State<NewTasksScreen> {
  List<TaskModel> newTasks = [];
  SqlDb db = SqlDb();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    db
        .readDataShortcut(query: "tasks", where: '"status" = "newTask"')
        .then((value) {
      for (var t in value) {
        var task = TaskModel.fromJson(t);
        newTasks.add(task);
        print(task.id);
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: newTasks.length,
        itemBuilder: (context, index) {
          return TaskWidget(
            task: newTasks[index],
          );
        });
  }
}
