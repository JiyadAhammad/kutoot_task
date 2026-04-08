import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_app/src/features/task/data/models/task_model.dart';
import 'package:my_app/src/features/task/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final Dio _dio;
  final Box<TaskModel> _taskBox;

  TaskRepositoryImpl(this._dio, this._taskBox);

  @override
  List<TaskModel> getTasks() {
    return _taskBox.values
        .where((task) => task.isDeleted != true)
        .toList()
        .cast<TaskModel>();
  }

  @override
  Stream<List<TaskModel>> watchTasks() async* {
    yield getTasks();
    yield* _taskBox.watch().map((_) => getTasks());
  }

  @override
  Future<void> addTask(TaskModel task) async {
    final offlineTask = task.copyWith(isSynced: false);
    await _taskBox.put(task.id, offlineTask);

    try {
      await _dio.post(
        '/posts',
        data: {'title': task.title, 'body': 'task_simulation', 'userId': 1},
      );

      await _taskBox.put(task.id, task.copyWith(isSynced: true));
    } catch (e) {
      throw Exception('Network failed');
    }
  }

  @override
  Future<void> syncOfflineTasks() async {
    final tasks = _taskBox.values.toList();

    for (var task in tasks) {
      try {
        if (task.isDeleted) {
          await _dio.delete('/posts/${task.id}');
          await _taskBox.delete(task.id);
          continue;
        }

        if (!task.isSynced) {
          await _dio.post('/posts', data: {'title': task.title, 'userId': 1});

          await _taskBox.put(task.id, task.copyWith(isSynced: true));
        }
      } catch (e) {
        debugPrint('$e syncOfflineTasks');
      }
    }
  }

  @override
  Future<void> deleteTask(String taskId) async {
    final existingTask = _taskBox.get(taskId);

    if (existingTask == null) return;

    final deletedTask = existingTask.copyWith(isDeleted: true, isSynced: false);

    await _taskBox.put(taskId, deletedTask);

    try {
      await _dio.delete('/posts/${existingTask.id}');
      await _taskBox.delete(taskId);
    } catch (e) {
      await _taskBox.put(taskId, existingTask);

      throw Exception('Delete failed');
    }
  }
}
