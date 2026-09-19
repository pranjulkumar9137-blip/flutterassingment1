import 'package:flutter/foundation.dart';
import '../models/task.dart';

class TaskProvider extends ChangeNotifier {
  final List<Task> _tasks = [];

  // Tasks ko UI ke liye provide karna
  List<Task> get tasks => _tasks;

  // Task add karna
  void addTask(String title) {
    if (title.trim().isEmpty) {
      return;
    }

    _tasks.add(
      Task(
        title: title.trim(),
      ),
    );

    // UI ko update karega
    notifyListeners();
  }

  // Task complete / incomplete
  void toggleTask(int index) {
    _tasks[index].isCompleted =
    !_tasks[index].isCompleted;

    notifyListeners();
  }

  // Task delete karna
  void deleteTask(int index) {
    _tasks.removeAt(index);

    notifyListeners();
  }

  // Completed tasks count
  int get completedTasks {
    return _tasks
        .where((task) => task.isCompleted)
        .length;
  }

  // Total tasks count
  int get totalTasks {
    return _tasks.length;
  }

  // Progress calculate karna
  double get progress {
    if (_tasks.isEmpty) {
      return 0;
    }

    return completedTasks / totalTasks;
  }
}