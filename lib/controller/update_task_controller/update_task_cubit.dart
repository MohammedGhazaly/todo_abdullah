import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do_abdullah/model/task_model.dart';
import 'package:to_do_abdullah/utils/local_db.dart';

part 'update_task_state.dart';

class UpdateTaskCubit extends Cubit<UpdateTaskState> {
  UpdateTaskCubit() : super(UpdateTaskInitial());
  SqlDb sqlDb = SqlDb();
  List<TaskModel> archivedTasks = [];
  List<TaskModel> doneTasks = [];
  void updateTask(
      {required Map<String, Object?> values, required String where}) async {
    await sqlDb.updateShortcut(table: "tasks", values: values, where: where);
    getUpdatedTasks();
  }

  void getUpdatedTasks() async {
    archivedTasks = [];
    doneTasks = [];
    final archivedTasksJson = await sqlDb.readDataShortcut(
        query: "tasks", where: '"status" = "archivedTask"');
    final doneTasksJson = await sqlDb.readDataShortcut(
        query: "tasks", where: '"status" = "doneTask"');
    for (var t in archivedTasksJson) {
      var task = TaskModel.fromJson(t);
      archivedTasks.add(task);
    }
    for (var t in doneTasksJson) {
      var task = TaskModel.fromJson(t);
      doneTasks.add(task);
    }
    emit(GetUpdatedTasks());
  }
}
