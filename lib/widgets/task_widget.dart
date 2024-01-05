import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_abdullah/controller/modal_bottom_sheet_controller/modal_bottom_sheet_cubit.dart';
import 'package:to_do_abdullah/controller/update_task_controller/update_task_cubit.dart';
import 'package:to_do_abdullah/model/task_model.dart';

class TaskWidget extends StatelessWidget {
  final TaskModel task;
  const TaskWidget({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    late Color color;
    switch (task.status) {
      case TaskStatus.newTask:
        color = Colors.blue;
      case TaskStatus.archivedTask:
        color = Colors.grey;
      case TaskStatus.doneTask:
        color = Colors.green;
    }
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: color,
            radius: 40,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                task.time,
                textAlign: TextAlign.center,
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
                  style: const TextStyle(
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
          ),
          task.status == TaskStatus.newTask
              ? InkWell(
                  // radius: 50,
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {
                    BlocProvider.of<UpdateTaskCubit>(context).updateTask(
                      values: {
                        "status": TaskStatus.doneTask.name,
                      },
                      where: '"id" = ${task.id}',
                    );
                    BlocProvider.of<ModalBottomSheetCubit>(context,
                            listen: false)
                        .getAllNewTasks();
                  },
                  child: const Icon(
                    Icons.done,
                    color: Colors.green,
                    size: 32,
                  ),
                )
              : InkWell(
                  // radius: 50,
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {
                    BlocProvider.of<UpdateTaskCubit>(context).deleteTasks(
                      where: '"id" = ${task.id}',
                    );
                  },
                  child: const Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 32,
                  ),
                ),
          const SizedBox(
            width: 7,
          ),
          task.status == TaskStatus.newTask
              ? InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {
                    BlocProvider.of<UpdateTaskCubit>(context).updateTask(
                      values: {
                        "status": TaskStatus.archivedTask.name,
                      },
                      where: '"id" = ${task.id}',
                    );
                    BlocProvider.of<ModalBottomSheetCubit>(context,
                            listen: false)
                        .getAllNewTasks();
                  },
                  child: const Icon(
                    Icons.archive_rounded,
                    color: Colors.grey,
                    size: 32,
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
