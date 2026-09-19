import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/task_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Task add dialog
  void showAddTaskDialog(BuildContext context) {
    final TextEditingController controller =
    TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Add New Task',
          ),

          content: TextField(
            controller: controller,

            autofocus: true,

            decoration: const InputDecoration(
              labelText: 'Task name',
              hintText: 'Enter your task',
              border: OutlineInputBorder(),
            ),
          ),

          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text('Cancel'),
            ),

            ElevatedButton(
              onPressed: () {

                final title =
                controller.text.trim();

                if (title.isNotEmpty) {

                  context
                      .read<TaskProvider>()
                      .addTask(title);

                  Navigator.pop(context);
                }
              },

              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'Daily Task Tracker',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        centerTitle: true,
      ),

      body: SafeArea(

        child: Consumer<TaskProvider>(
          builder: (
              context,
              taskProvider,
              child,
              ) {

            return Column(
              children: [

                // ==========================================
                // HEADER
                // ==========================================

                Container(
                  width: double.infinity,

                  margin: const EdgeInsets.all(16),

                  padding: const EdgeInsets.all(20),

                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(20),

                    color: Colors.deepPurple.shade50,
                  ),

                  child: Column(
                    children: [

                      const Icon(
                        Icons.task_alt,
                        size: 55,
                        color: Colors.deepPurple,
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        'Stay Productive!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        '${taskProvider.completedTasks} '
                            'of ${taskProvider.totalTasks} '
                            'tasks completed',

                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade700,
                        ),
                      ),

                      const SizedBox(height: 15),

                      // Progress bar
                      LinearProgressIndicator(
                        value: taskProvider.progress,

                        minHeight: 8,

                        borderRadius:
                        BorderRadius.circular(10),
                      ),
                    ],
                  ),
                ),

                // ==========================================
                // TASK TITLE
                // ==========================================

                Padding(
                  padding:
                  const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),

                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                    children: [

                      const Text(
                        'My Tasks',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        '${taskProvider.totalTasks} Tasks',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // ==========================================
                // TASK LIST
                // ==========================================

                Expanded(

                  child: taskProvider.tasks.isEmpty

                      ? const Center(
                    child: Column(
                      mainAxisAlignment:
                      MainAxisAlignment.center,

                      children: [

                        Icon(
                          Icons.assignment_outlined,
                          size: 80,
                          color: Colors.grey,
                        ),

                        SizedBox(height: 15),

                        Text(
                          'No tasks yet!',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 5),

                        Text(
                          'Tap + to add your first task.',
                        ),
                      ],
                    ),
                  )

                      : ListView.builder(

                    padding:
                    const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),

                    itemCount:
                    taskProvider.tasks.length,

                    itemBuilder:
                        (context, index) {

                      final task =
                      taskProvider.tasks[index];

                      return Card(

                        margin:
                        const EdgeInsets.only(
                          bottom: 10,
                        ),

                        child: ListTile(

                          contentPadding:
                          const EdgeInsets
                              .symmetric(
                            horizontal: 12,
                            vertical: 5,
                          ),

                          // Complete checkbox
                          leading: Checkbox(
                            value:
                            task.isCompleted,

                            onChanged: (_) {

                              context
                                  .read<TaskProvider>()
                                  .toggleTask(index);
                            },
                          ),

                          // Task title
                          title: Text(
                            task.title,

                            style: TextStyle(

                              fontSize: 16,

                              fontWeight:
                              FontWeight.w500,

                              decoration:
                              task.isCompleted
                                  ? TextDecoration
                                  .lineThrough
                                  : null,

                              color:
                              task.isCompleted
                                  ? Colors.grey
                                  : null,
                            ),
                          ),

                          // Delete button
                          trailing: IconButton(

                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                            ),

                            onPressed: () {

                              context
                                  .read<TaskProvider>()
                                  .deleteTask(index);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),

      // ================================================
      // ADD TASK BUTTON
      // ================================================

      floatingActionButton:
      FloatingActionButton.extended(

        onPressed: () {
          showAddTaskDialog(context);
        },

        icon: const Icon(Icons.add),

        label: const Text('Add Task'),
      ),
    );
  }
}