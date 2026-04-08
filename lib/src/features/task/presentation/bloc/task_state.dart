part of 'task_bloc.dart';

@freezed
class TaskState with _$TaskState {
  const factory TaskState.initial() = _Initial;
  const factory TaskState.loading() = _Loading;
  const factory TaskState.loaded(List<TaskModel> tasks) = _Loaded;
  const factory TaskState.error(String message, List<TaskModel> tasks) = _Error;
}
