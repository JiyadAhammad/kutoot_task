import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

@freezed
@HiveType(typeId: 0)
abstract class TaskModel with _$TaskModel {
  factory TaskModel({
    @HiveField(0) required String id,
    @HiveField(1) required String title,
    @HiveField(2) @Default(false) bool isCompleted,
    @HiveField(3) @Default(true) bool isSynced, // true if synced with API
    @HiveField(4) @Default(false) bool isDeleted,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);
}
