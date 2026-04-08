import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_app/src/core/network/dio_client.dart';
import 'package:my_app/src/core/network/connectivity_service.dart';
import 'package:my_app/src/features/task/data/models/task_model.dart';
import 'package:my_app/src/features/task/domain/repositories/task_repository.dart';
import 'package:my_app/src/features/task/data/repositories/task_repository_impl.dart';
import 'package:my_app/src/features/task/presentation/bloc/task_bloc.dart';
import 'package:my_app/src/features/feed/domain/repositories/feed_repository.dart';
import 'package:my_app/src/features/feed/data/repositories/feed_repository_impl.dart';
import 'package:my_app/src/features/feed/presentation/bloc/feed_bloc.dart';

final sl = GetIt.instance;

Future<void> setupInjection() async {
  // Register Core Services
  sl.registerLazySingleton<DioClient>(() => DioClient());
  sl.registerLazySingleton<ConnectivityService>(() => ConnectivityService());

  // Register Repositories
  sl.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(sl<DioClient>().dio, Hive.box<TaskModel>('tasks')),
  );
  sl.registerLazySingleton<FeedRepository>(
    () => FeedRepositoryImpl(sl<DioClient>().dio),
  );

  // Register Blocs
  sl.registerFactory(() => TaskBloc(sl<TaskRepository>()));
  sl.registerFactory(() => FeedBloc(sl<FeedRepository>()));
}
