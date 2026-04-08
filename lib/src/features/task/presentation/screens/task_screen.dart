import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/src/features/task/data/models/task_model.dart';
import 'package:my_app/src/features/task/presentation/bloc/task_bloc.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shared Task Manager'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sync),
            tooltip: 'Sync Offline Tasks',
            onPressed: () {
              context.read<TaskBloc>().add(const TaskEvent.syncOffline());
            },
          ),
        ],
      ),
      body: BlocConsumer<TaskBloc, TaskState>(
        listener: (context, state) {
          state.maybeWhen(
            error: (message, _) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: Colors.redAccent,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (tasks) => _TaskList(tasks: tasks.reversed.toList()),
            error: (_, tasks) =>
                _TaskList(tasks: tasks.reversed.toList()), // Show cached data
            orElse: () => const Center(child: Text('No tasks available.')),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Add New Task'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Enter task description',
              border: OutlineInputBorder(),
            ),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final text = controller.text.trim();
                if (text.isNotEmpty) {
                  final task = TaskModel(
                    id: DateTime.now().toIso8601String(), // Mock ID
                    title: text,
                    isCompleted: false,
                    isSynced: false,
                  );
                  context.read<TaskBloc>().add(TaskEvent.addTask(task));
                  Navigator.pop(dialogContext);
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

class _TaskList extends StatelessWidget {
  final List<TaskModel> tasks;

  const _TaskList({required this.tasks});

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(25.0),
          child: Text(
            'No tasks yet.\nCreate your new task by click +',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
        ),
      );
    }
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return ListTile(
          title: Text(
            task.title,
            style: TextStyle(
              decoration: task.isCompleted ? TextDecoration.lineThrough : null,
              color: task.isCompleted ? Colors.grey : Colors.black87,
            ),
          ),
          trailing: Row(
            mainAxisSize: .min,
            children: [
              Tooltip(
                message: task.isSynced
                    ? 'Synced to Cloud'
                    : 'Waiting for connection',
                child: task.isSynced
                    ? const Icon(Icons.cloud_done, color: Colors.green)
                    : const Icon(Icons.cloud_off, color: Colors.grey),
              ),
              IconButton(
                onPressed: () {
                  context.read<TaskBloc>().add(TaskEvent.deleteTask(task.id));
                },
                icon: Icon(Icons.delete, color: Colors.red),
              ),
            ],
          ),
        );
      },
    );
  }
}
