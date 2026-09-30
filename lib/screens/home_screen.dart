import 'package:flutter/material.dart';

import '../models/todo_model.dart';
import '../services/auth_service.dart';
import '../services/notification_service.dart';
import '../services/todo_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TodoService _todoService = TodoService();
  final AuthService _authService = AuthService();

  int _notificationId(String todoId) {
    return todoId.hashCode & 0x7fffffff;
  }

  Future<void> _logout() async {
    await _authService.logout();
  }

  Future<void> _deleteTodo(TodoModel todo) async {
    try {
      await NotificationService.cancelReminder(
        _notificationId(todo.id),
      );

      await _todoService.deleteTodo(todo.id);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('TODO deleted'),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Delete failed: $e'),
        ),
      );
    }
  }

  Future<void> _toggleTodo(TodoModel todo) async {
    try {
      await _todoService.toggleTodo(
        todo.id,
        !todo.isCompleted,
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Update failed: $e'),
        ),
      );
    }
  }

  Future<DateTime?> _selectReminderDateTime(
      BuildContext context,
      DateTime? current,
      ) async {
    final now = DateTime.now();

    DateTime initialDate = current ?? now;

    if (initialDate.isBefore(now)) {
      initialDate = now;
    }

    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(now.year, now.month, now.day),
      lastDate: DateTime(now.year + 5),
    );

    if (date == null) {
      return null;
    }

    if (!context.mounted) return null;

    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: current != null
          ? TimeOfDay.fromDateTime(current)
          : TimeOfDay.now(),
    );

    if (time == null) {
      return null;
    }

    return DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
  }

  Future<void> _showTodoDialog({
    TodoModel? todo,
  }) async {
    final titleController = TextEditingController(
      text: todo?.title ?? '',
    );

    final descriptionController = TextEditingController(
      text: todo?.description ?? '',
    );

    DateTime? reminderAt = todo?.reminderAt;

    final formKey = GlobalKey<FormState>();

    await showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(
                todo == null ? 'Add TODO' : 'Edit TODO',
              ),
              content: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: titleController,
                        decoration: const InputDecoration(
                          labelText: 'Title',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty) {
                            return 'Enter TODO title';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 15),

                      TextFormField(
                        controller: descriptionController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 15),

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius:
                          BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Reminder',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              reminderAt == null
                                  ? 'No reminder selected'
                                  : _formatDateTime(
                                reminderAt!,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: () async {
                                      final selected =
                                      await _selectReminderDateTime(
                                        context,
                                        reminderAt,
                                      );

                                      if (selected != null) {
                                        setDialogState(() {
                                          reminderAt =
                                              selected;
                                        });
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.alarm,
                                    ),
                                    label: const Text(
                                      'Set Reminder',
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            if (reminderAt != null)
                              TextButton.icon(
                                onPressed: () {
                                  setDialogState(() {
                                    reminderAt = null;
                                  });
                                },
                                icon: const Icon(
                                  Icons.clear,
                                ),
                                label: const Text(
                                  'Remove Reminder',
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  child: const Text('Cancel'),
                ),

                ElevatedButton(
                  onPressed: () async {
                    if (!formKey.currentState!.validate()) {
                      return;
                    }

                    final title =
                    titleController.text.trim();

                    final description =
                    descriptionController.text.trim();

                    // Reminder cannot be in the past
                    if (reminderAt != null &&
                        reminderAt!.isBefore(DateTime.now())) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Reminder time must be in the future',
                          ),
                        ),
                      );

                      return;
                    }

                    try {
                      if (todo == null) {
                        // Create new TODO
                        final newTodo = TodoModel(
                          id: '',
                          title: title,
                          description: description,
                          isCompleted: false,
                          reminderAt: reminderAt,
                        );

                        final id =
                        await _todoService.addTodo(
                          newTodo,
                        );

                        // Schedule notification
                        if (reminderAt != null) {
                          await NotificationService
                              .scheduleReminder(
                            notificationId:
                            _notificationId(id),
                            title: 'TODO Reminder',
                            body: title,
                            reminderTime: reminderAt!,
                          );
                        }
                      } else {
                        // Cancel old reminder first
                        await NotificationService
                            .cancelReminder(
                          _notificationId(todo.id),
                        );

                        final updatedTodo = TodoModel(
                          id: todo.id,
                          title: title,
                          description: description,
                          isCompleted: todo.isCompleted,
                          reminderAt: reminderAt,
                        );

                        await _todoService.updateTodo(
                          updatedTodo,
                        );

                        // Schedule new reminder
                        if (reminderAt != null) {
                          await NotificationService
                              .scheduleReminder(
                            notificationId:
                            _notificationId(todo.id),
                            title: 'TODO Reminder',
                            body: title,
                            reminderTime: reminderAt!,
                          );
                        }
                      }

                      if (!context.mounted) return;

                      Navigator.pop(dialogContext);

                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        SnackBar(
                          content: Text(
                            todo == null
                                ? 'TODO added'
                                : 'TODO updated',
                          ),
                        ),
                      );
                    } catch (e) {
                      if (!context.mounted) return;

                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        SnackBar(
                          content: Text(
                            'Something went wrong: $e',
                          ),
                        ),
                      );
                    }
                  },
                  child: Text(
                    todo == null ? 'Add' : 'Update',
                  ),
                ),
              ],
            );
          },
        );
      },
    );

    titleController.dispose();
    descriptionController.dispose();
  }

  String _formatDateTime(DateTime dateTime) {
    final day = dateTime.day.toString().padLeft(2, '0');
    final month = dateTime.month.toString().padLeft(2, '0');
    final year = dateTime.year.toString();

    final hour = dateTime.hour == 0
        ? 12
        : dateTime.hour > 12
        ? dateTime.hour - 12
        : dateTime.hour;

    final minute =
    dateTime.minute.toString().padLeft(2, '0');

    final period = dateTime.hour >= 12 ? 'PM' : 'AM';

    return '$day/$month/$year  $hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My TODOs'),
        actions: [
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
          ),
        ],
      ),

      body: StreamBuilder<List<TodoModel>>(
        stream: _todoService.getTodos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
              ),
            );
          }

          final todos = snapshot.data ?? [];

          if (todos.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment:
                MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.task_alt,
                    size: 70,
                  ),
                  SizedBox(height: 15),
                  Text(
                    'No TODO tasks',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Add your first task',
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];

              return Card(
                margin: const EdgeInsets.only(
                  bottom: 12,
                ),
                child: ListTile(
                  contentPadding:
                  const EdgeInsets.all(12),

                  leading: Checkbox(
                    value: todo.isCompleted,
                    onChanged: (_) {
                      _toggleTodo(todo);
                    },
                  ),

                  title: Text(
                    todo.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      decoration: todo.isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),

                  subtitle: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      if (todo.description.isNotEmpty)
                        Padding(
                          padding:
                          const EdgeInsets.only(top: 5),
                          child: Text(
                            todo.description,
                          ),
                        ),

                      if (todo.reminderAt != null)
                        Padding(
                          padding:
                          const EdgeInsets.only(top: 8),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.alarm,
                                size: 18,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                _formatDateTime(
                                  todo.reminderAt!,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),

                  trailing: PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') {
                        _showTodoDialog(todo: todo);
                      }

                      if (value == 'delete') {
                        _deleteTodo(todo);
                      }
                    },
                    itemBuilder: (context) {
                      return const [
                        PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(Icons.edit),
                              SizedBox(width: 8),
                              Text('Edit'),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete),
                              SizedBox(width: 8),
                              Text('Delete'),
                            ],
                          ),
                        ),
                      ];
                    },
                  ),
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showTodoDialog();
        },
        icon: const Icon(Icons.add),
        label: const Text('Add TODO'),
      ),
    );
  }
}