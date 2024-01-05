import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_abdullah/controller/modal_bottom_sheet_controller/modal_bottom_sheet_cubit.dart';
import 'package:to_do_abdullah/model/task_model.dart';
import 'package:to_do_abdullah/utils/local_db.dart';
import 'package:to_do_abdullah/widgets/task_widget.dart';

class NewTasksScreen extends StatelessWidget {
  const NewTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final modalBottomSheetCubit =
        BlocProvider.of<ModalBottomSheetCubit>(context, listen: true);
    return ListView.builder(
      itemCount: modalBottomSheetCubit.newTasks.length,
      itemBuilder: (context, index) {
        return TaskWidget(
          task: modalBottomSheetCubit.newTasks[index],
        );
      },
    );
  }
}
