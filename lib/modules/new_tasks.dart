import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_abdullah/controller/modal_bottom_sheet_controller/modal_bottom_sheet_cubit.dart';
import 'package:to_do_abdullah/model/task_model.dart';
import 'package:to_do_abdullah/utils/local_db.dart';
import 'package:to_do_abdullah/widgets/task_widget.dart';

class NewTasksScreen extends StatefulWidget {
  const NewTasksScreen({super.key});

  @override
  State<NewTasksScreen> createState() => _NewTasksScreenState();
}

class _NewTasksScreenState extends State<NewTasksScreen> {
  @override
  void initState() {
    super.initState();
  }

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
