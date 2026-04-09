import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:my_app/src/core/database/hive_setup.dart';
import 'package:my_app/src/core/di/locator.dart';
import 'package:my_app/src/core/network/connectivity_service.dart';
import 'package:my_app/src/features/feed/presentation/bloc/feed_bloc.dart';
import 'package:my_app/src/features/feed/presentation/screens/feed_screen.dart';
import 'package:my_app/src/features/home/bloc/dashboard_bloc.dart';
import 'package:my_app/src/features/task/presentation/bloc/task_bloc.dart';
import 'package:my_app/src/features/task/presentation/screens/task_screen.dart';

import 'src/features/home/presentation/pages/kutoot_dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveSetup.init();
  await setupInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<TaskBloc>()..add(const TaskEvent.started()),
        ),
        BlocProvider(create: (context) => sl<FeedBloc>()),
        BlocProvider(
          create: (context) =>
              sl<DashboardBloc>()..add(DashboardEvent.fetchLocationRequested()),
        ),
      ],
      child: MaterialApp(
        title: 'Kutoot Assignment',
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Color(0xFF6750A4),
            foregroundColor: Colors.white,
          ),
        ),
        home: const KutootDashboard(),
      ),
    );
  }
}

class AppMainScreen extends StatefulWidget {
  const AppMainScreen({super.key});

  @override
  State<AppMainScreen> createState() => _AppMainScreenState();
}

class _AppMainScreenState extends State<AppMainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [FeedScreen(), TaskScreen()];

  @override
  void initState() {
    super.initState();
    // Re-sync offline jobs when the user gets back online
    sl<ConnectivityService>().onConnectivityChanged.listen((results) {
      if (!results.contains(ConnectivityResult.none)) {
        if (mounted) {
          context.read<TaskBloc>().add(const TaskEvent.syncOffline());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.feed_outlined),
            selectedIcon: Icon(Icons.feed),
            label: 'Canvas',
          ),
          NavigationDestination(
            icon: Icon(Icons.task_alt_outlined),
            selectedIcon: Icon(Icons.task_alt),
            label: 'Tasks',
          ),
        ],
      ),
    );
  }
}
