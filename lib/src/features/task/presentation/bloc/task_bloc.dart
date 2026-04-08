import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/src/features/task/data/models/task_model.dart';
import 'package:my_app/src/features/task/domain/repositories/task_repository.dart';

part 'task_bloc.freezed.dart';
part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository _repository;
  StreamSubscription? _tasksSubscription;

  TaskBloc(this._repository) : super(const TaskState.initial()) {
    on<_Started>(_onStarted);
    on<_AddTask>(_onAddTask);
    on<_SyncOffline>(_onSyncOffline);
    on<_TasksUpdated>(_onTasksUpdated);
    on<_DeleteTask>(_onDeleteTask);
  }

  void _onStarted(_Started event, Emitter<TaskState> emit) {
    emit(const TaskState.loading());
    _tasksSubscription?.cancel();
    _tasksSubscription = _repository.watchTasks().listen((tasks) {
      add(TaskEvent.tasksUpdated(tasks));
    });
  }

  void _onTasksUpdated(_TasksUpdated event, Emitter<TaskState> emit) {
    emit(TaskState.loaded(event.tasks));
  }

  Future<void> _onAddTask(_AddTask event, Emitter<TaskState> emit) async {
    try {
      await _repository.addTask(event.task);
    } catch (e) {
      if (state is _Loaded) {
        final currentData = (state as _Loaded).tasks;
        emit(TaskState.error("Failed to sync new task", currentData));
        emit(TaskState.loaded(currentData));
      }
    }
  }

  Future<void> _onSyncOffline(
    _SyncOffline event,
    Emitter<TaskState> emit,
  ) async {
    await _repository.syncOfflineTasks();
  }

  @override
  Future<void> close() {
    _tasksSubscription?.cancel();
    return super.close();
  }

  Future<void> _onDeleteTask(_DeleteTask event, Emitter<TaskState> emit) async {
    try {
      await _repository.deleteTask(event.taskId);
    } catch (e) {
      if (state is _Loaded) {
        final currentData = (state as _Loaded).tasks;

        emit(TaskState.error("Failed to delete task", currentData));
        emit(TaskState.loaded(currentData));
      }
    }
  }
}
