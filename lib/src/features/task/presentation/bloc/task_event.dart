part of 'task_bloc.dart';

@freezed
class TaskEvent with _$TaskEvent {
  const factory TaskEvent.started() = _Started;
  const factory TaskEvent.tasksUpdated(List<TaskModel> tasks) = _TasksUpdated;
  const factory TaskEvent.addTask(TaskModel task) = _AddTask;
  const factory TaskEvent.syncOffline() = _SyncOffline;
  const factory TaskEvent.deleteTask(String taskId) = _DeleteTask;
}
