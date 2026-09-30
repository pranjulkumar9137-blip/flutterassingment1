import 'package:flutter/foundation.dart';

import '../models/task.dart';

class TaskProvider extends ChangeNotifier {
  final List<Task> _tasks = [
    Task(
      id: '1',
      title: 'Complete Flutter Assignment',
      description: 'Finish the UI and test all screens.',
      category: 'Study',
      priority: TaskPriority.high,
      dueDate: DateTime.now(),
    ),
    Task(
      id: '2',
      title: 'Practice Java',
      description: 'Revise Spring Boot CRUD concepts.',
      category: 'Study',
      priority: TaskPriority.medium,
      dueDate: DateTime.now().add(
        const Duration(days: 1),
      ),
    ),
    Task(
      id: '3',
      title: 'Go for a Walk',
      description: 'Take a short evening walk.',
      category: 'Personal',
      priority: TaskPriority.low,
      dueDate: DateTime.now(),
      completed: true,
    ),
  ];

  String _query = '';
  String _category = 'All';

  List<Task> get tasks => List.unmodifiable(_tasks);

  String get searchQuery => _query;

  String get selectedCategory => _category;

  List<String> get categories {
    final values = _tasks
        .map((task) => task.category)
        .toSet()
        .toList();

    values.sort();

    return [
      'All',
      ...values,
    ];
  }

  List<Task> get filteredTasks {
    return _tasks.where((task) {
      final matchesQuery =
          task.title.toLowerCase().contains(
            _query.toLowerCase(),
          ) ||
              task.description.toLowerCase().contains(
                _query.toLowerCase(),
              );

      final matchesCategory =
          _category == 'All' ||
              task.category == _category;

      return matchesQuery && matchesCategory;
    }).toList();
  }

  int get totalCount => _tasks.length;

  int get completedCount =>
      _tasks.where((task) => task.completed).length;

  int get pendingCount =>
      totalCount - completedCount;

  double get completionRate {
    if (totalCount == 0) {
      return 0;
    }

    return completedCount / totalCount;
  }

  void setSearchQuery(String value) {
    _query = value;
    notifyListeners();
  }

  void setCategory(String value) {
    _category = value;
    notifyListeners();
  }

  void addTask({
    required String title,
    required String description,
    required String category,
    required TaskPriority priority,
    required DateTime dueDate,
  }) {
    _tasks.insert(
      0,
      Task(
        id: DateTime.now()
            .microsecondsSinceEpoch
            .toString(),
        title: title,
        description: description,
        category: category,
        priority: priority,
        dueDate: dueDate,
      ),
    );

    notifyListeners();
  }

  void updateTask(
      Task oldTask, {
        required String title,
        required String description,
        required String category,
        required TaskPriority priority,
        required DateTime dueDate,
      }) {
    final index = _tasks.indexWhere(
          (task) => task.id == oldTask.id,
    );

    if (index == -1) {
      return;
    }

    _tasks[index] = oldTask.copyWith(
      title: title,
      description: description,
      category: category,
      priority: priority,
      dueDate: dueDate,
    );

    notifyListeners();
  }

  void toggleTask(String id) {
    final index = _tasks.indexWhere(
          (task) => task.id == id,
    );

    if (index == -1) {
      return;
    }

    final task = _tasks[index];

    _tasks[index] = task.copyWith(
      completed: !task.completed,
    );

    notifyListeners();
  }

  void deleteTask(String id) {
    _tasks.removeWhere(
          (task) => task.id == id,
    );

    notifyListeners();
  }
}