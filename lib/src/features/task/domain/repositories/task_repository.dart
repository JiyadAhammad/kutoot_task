import 'package:my_app/src/features/task/data/models/task_model.dart';

abstract class TaskRepository {
  List<TaskModel> getTasks();
  Stream<List<TaskModel>> watchTasks();
  Future<void> addTask(TaskModel task);
  // Future<void> updateTask(TaskModel task);
  Future<void> syncOfflineTasks();
  Future<void> deleteTask(String taskId);
}
