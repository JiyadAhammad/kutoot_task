import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_app/src/features/task/data/models/task_model.dart';

class HiveSetup {
  static Future<void> init() async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(TaskModelAdapter().typeId)) {
      Hive.registerAdapter(TaskModelAdapter());
    }

    await Hive.openBox<TaskModel>('tasks');
  }
}
