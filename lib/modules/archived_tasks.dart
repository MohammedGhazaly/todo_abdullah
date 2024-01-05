import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_abdullah/controller/modal_bottom_sheet_controller/modal_bottom_sheet_cubit.dart';
import 'package:to_do_abdullah/controller/update_task_controller/update_task_cubit.dart';
import 'package:to_do_abdullah/widgets/task_widget.dart';

class ArchivedTasksScreen extends StatelessWidget {
  const ArchivedTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final updateTaskCubit =
        BlocProvider.of<UpdateTaskCubit>(context, listen: true);
    return ListView.builder(
      itemCount: updateTaskCubit.archivedTask.length,
      itemBuilder: (context, index) {
        return TaskWidget(
          task: updateTaskCubit.archivedTask[index],
        );
      },
    );
  }
}
