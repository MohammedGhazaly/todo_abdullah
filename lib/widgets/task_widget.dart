import 'package:flutter/material.dart';
import 'package:to_do_abdullah/model/task_model.dart';

class TaskWidget extends StatelessWidget {
  final TaskModel task;
  const TaskWidget({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 40,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                task.time,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  task.title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  task.date,
                  style: TextStyle(color: Colors.grey[700], fontSize: 16),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
