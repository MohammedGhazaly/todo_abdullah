part of 'update_task_cubit.dart';

@immutable
sealed class UpdateTaskState {}

final class UpdateTaskInitial extends UpdateTaskState {}

final class UpdateTaskArchived extends UpdateTaskState {}

final class UpdateTaskDone extends UpdateTaskState {}

final class GetTasks extends UpdateTaskState {}

final class TaskDeleted extends UpdateTaskState {}
