import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:to_do_abdullah/model/task_model.dart';
import 'package:to_do_abdullah/utils/local_db.dart';
import 'package:to_do_abdullah/widgets/tasks_modal_bottom_sheet.dart';

part 'modal_bottom_sheet_state.dart';

class ModalBottomSheetCubit extends Cubit<ModalBottomSheetState> {
  ModalBottomSheetCubit() : super(ModalBottomSheetClosed());
  bool isBottomSheetOpened = false;
  SqlDb sqlDb = SqlDb();
  List<TaskModel> newTasks = [];
  List<TaskModel> archIvedTasks = [];
  List<TaskModel> doneTasks = [];
  bool isFirstTimeFetch = true;

  PersistentBottomSheetController? controller;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void settingModalBottomSheet() {
    controller = scaffoldKey.currentState!.showBottomSheet(
        backgroundColor: Colors.white, enableDrag: false, (context) {
      return const TasksModalBottomSheet();
    });
    emit(ModalBottomSheetOpended());
  }

  void closeModalBottomSheet() {
    if (controller != null) {
      controller!.close();

      controller = null;
    }

    emit(ModalBottomSheetClosed());
  }

  void addTask(Map<String, Object?> task) async {
    await sqlDb.insertShortcut(task: task);
    getAllNewTasks();
    closeModalBottomSheet();
  }

  Future<void> getAllNewTasks() async {
    newTasks = [];
    final tasks = await sqlDb.readDataShortcut(
        query: "tasks", where: '"status" = "newTask"');
    for (var t in tasks) {
      var task = TaskModel.fromJson(t);
      newTasks.add(task);
    }
    emit(TasksFetched());
  }
}
