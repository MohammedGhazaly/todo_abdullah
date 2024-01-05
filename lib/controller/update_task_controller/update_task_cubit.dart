import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do_abdullah/model/task_model.dart';
import 'package:to_do_abdullah/utils/local_db.dart';

part 'update_task_state.dart';

class UpdateTaskCubit extends Cubit<UpdateTaskState> {
  UpdateTaskCubit() : super(UpdateTaskInitial());
  SqlDb sqlDb = SqlDb();
  List<TaskModel> archivedTask = [];
  void updateTask(
      {required Map<String, Object?> values, required String where}) async {
    await sqlDb.updateShortcut(table: "tasks", values: values, where: where);
    getArchivedTasks();
  }

  void getArchivedTasks() async {
    print("clicked");

    archivedTask = [];
    final tasks = await sqlDb.readDataShortcut(
        query: "tasks", where: '"status" = "archivedTask"');
    for (var t in tasks) {
      var task = TaskModel.fromJson(t);
      archivedTask.add(task);
    }
    emit(GetUpdatedTasks());
  }
}
