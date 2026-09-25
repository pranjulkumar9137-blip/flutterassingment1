import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/todo_model.dart';
import '../services/auth_service.dart';
import '../services/todo_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState
    extends State<HomeScreen> {

  final AuthService _authService =
  AuthService();

  final TodoService _todoService =
  TodoService();

  final titleController =
  TextEditingController();

  final descriptionController =
  TextEditingController();

  // ==========================================
  // ADD TODO DIALOG
  // ==========================================

  void showAddTodoDialog() {

    titleController.clear();
    descriptionController.clear();

    showDialog(
      context: context,

      builder: (context) {

        return AlertDialog(

          title: const Text(
            'Add TODO',
          ),

          content: SingleChildScrollView(

            child: Column(
              mainAxisSize:
              MainAxisSize.min,

              children: [

                TextField(
                  controller:
                  titleController,

                  decoration:
                  const InputDecoration(
                    labelText:
                    'Task title',

                    border:
                    OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 15),

                TextField(
                  controller:
                  descriptionController,

                  maxLines: 3,

                  decoration:
                  const InputDecoration(
                    labelText:
                    'Description',

                    border:
                    OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),

          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child:
              const Text('Cancel'),
            ),

            ElevatedButton(
              onPressed: () async {

                final title =
                titleController.text.trim();

                final description =
                descriptionController
                    .text
                    .trim();

                if (title.isEmpty) {
                  return;
                }

                final user =
                    FirebaseAuth
                        .instance
                        .currentUser;

                if (user == null) {
                  return;
                }

                try {

                  await _todoService.addTodo(
                    uid: user.uid,
                    title: title,
                    description:
                    description,
                  );

                  if (!context.mounted) return;

                  Navigator.pop(context);

                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(
                    const SnackBar(
                      content:
                      Text('TODO added!'),
                    ),
                  );

                } catch (e) {

                  if (!context.mounted) return;

                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(
                    SnackBar(
                      content:
                      Text('Error: $e'),
                    ),
                  );
                }
              },

              child:
              const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  // ==========================================
  // EDIT TODO DIALOG
  // ==========================================

  void showEditTodoDialog(
      TodoModel todo,
      ) {

    titleController.text =
        todo.title;

    descriptionController.text =
        todo.description;

    showDialog(
      context: context,

      builder: (context) {

        return AlertDialog(

          title:
          const Text('Edit TODO'),

          content: SingleChildScrollView(

            child: Column(
              mainAxisSize:
              MainAxisSize.min,

              children: [

                TextField(
                  controller:
                  titleController,

                  decoration:
                  const InputDecoration(
                    labelText:
                    'Task title',

                    border:
                    OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 15),

                TextField(
                  controller:
                  descriptionController,

                  maxLines: 3,

                  decoration:
                  const InputDecoration(
                    labelText:
                    'Description',

                    border:
                    OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),

          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child:
              const Text('Cancel'),
            ),

            ElevatedButton(
              onPressed: () async {

                final user =
                    FirebaseAuth
                        .instance
                        .currentUser;

                if (user == null) return;

                try {

                  await _todoService
                      .updateTodo(
                    uid: user.uid,
                    todoId: todo.id,
                    title:
                    titleController
                        .text
                        .trim(),
                    description:
                    descriptionController
                        .text
                        .trim(),
                  );

                  if (!context.mounted) return;

                  Navigator.pop(context);

                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(
                    const SnackBar(
                      content:
                      Text('TODO updated!'),
                    ),
                  );

                } catch (e) {

                  if (!context.mounted) return;

                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(
                    SnackBar(
                      content:
                      Text('Error: $e'),
                    ),
                  );
                }
              },

              child:
              const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  // ==========================================
  // DELETE TODO
  // ==========================================

  Future<void> deleteTodo(
      TodoModel todo,
      ) async {

    final user =
        FirebaseAuth
            .instance
            .currentUser;

    if (user == null) return;

    try {

      await _todoService.deleteTodo(
        uid: user.uid,
        todoId: todo.id,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content:
          Text('TODO deleted!'),
        ),
      );

    } catch (e) {

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content:
          Text('Error: $e'),
        ),
      );
    }
  }

  // ==========================================
  // LOGOUT
  // ==========================================

  Future<void> logout() async {
    await _authService.logout();
  }

  // ==========================================
  // TODO CARD
  // ==========================================

  Widget buildTodoCard(
      TodoModel todo,
      ) {

    final user =
        FirebaseAuth
            .instance
            .currentUser;

    if (user == null) {
      return const SizedBox();
    }

    return Card(

      margin:
      const EdgeInsets.only(
        bottom: 12,
      ),

      child: Padding(

        padding:
        const EdgeInsets.all(10),

        child: ListTile(

          contentPadding:
          const EdgeInsets.symmetric(
            horizontal: 5,
          ),

          // CHECKBOX
          leading: Checkbox(
            value:
            todo.isCompleted,

            onChanged: (_) async {

              await _todoService
                  .toggleTodo(
                uid: user.uid,
                todoId: todo.id,
                isCompleted:
                todo.isCompleted,
              );
            },
          ),

          // TODO DATA
          title: Text(
            todo.title,

            maxLines: 2,

            overflow:
            TextOverflow.ellipsis,

            style: TextStyle(

              fontSize: 17,

              fontWeight:
              FontWeight.bold,

              decoration:
              todo.isCompleted
                  ? TextDecoration
                  .lineThrough
                  : null,
            ),
          ),

          subtitle:
          todo.description.isEmpty
              ? null
              : Padding(
            padding:
            const EdgeInsets
                .only(
              top: 5,
            ),

            child: Text(
              todo.description,

              maxLines: 2,

              overflow:
              TextOverflow
                  .ellipsis,
            ),
          ),

          // ACTIONS
          trailing: PopupMenuButton<String>(

            onSelected:
                (value) {

              if (value == 'edit') {

                showEditTodoDialog(
                  todo,
                );

              } else if (value ==
                  'delete') {

                deleteTodo(todo);
              }
            },

            itemBuilder:
                (context) => [

              const PopupMenuItem(
                value: 'edit',

                child: Row(
                  children: [
                    Icon(
                      Icons.edit,
                    ),
                    SizedBox(width: 8),
                    Text('Edit'),
                  ],
                ),
              ),

              const PopupMenuItem(
                value: 'delete',

                child: Row(
                  children: [
                    Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    SizedBox(width: 8),
                    Text('Delete'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {

    titleController.dispose();
    descriptionController.dispose();

    super.dispose();
  }

  // ==========================================
  // BUILD
  // ==========================================

  @override
  Widget build(BuildContext context) {

    final user =
        FirebaseAuth
            .instance
            .currentUser;

    if (user == null) {

      return const Scaffold(
        body: Center(
          child:
          Text('Please login again.'),
        ),
      );
    }

    return Scaffold(

      appBar: AppBar(

        title:
        const Text('My TODOs'),

        actions: [

          IconButton(
            tooltip: 'Logout',

            onPressed: logout,

            icon:
            const Icon(
              Icons.logout,
            ),
          ),
        ],
      ),

      body: SafeArea(

        child: StreamBuilder<
            List<TodoModel>>(
          stream:
          _todoService.getTodos(
            user.uid,
          ),

          builder:
              (context, snapshot) {

            // Loading
            if (snapshot.connectionState ==
                ConnectionState.waiting) {

              return const Center(
                child:
                CircularProgressIndicator(),
              );
            }

            // Error
            if (snapshot.hasError) {

              return Center(
                child: Padding(
                  padding:
                  const EdgeInsets.all(20),

                  child: Text(
                    'Unable to load TODOs.\n'
                        '${snapshot.error}',

                    textAlign:
                    TextAlign.center,
                  ),
                ),
              );
            }

            final todos =
                snapshot.data ?? [];

            // Empty
            if (todos.isEmpty) {

              return Center(

                child: Column(
                  mainAxisAlignment:
                  MainAxisAlignment.center,

                  children: [

                    Icon(
                      Icons
                          .checklist_outlined,

                      size: 90,

                      color:
                      Colors.grey.shade400,
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    const Text(
                      'No TODOs yet!',

                      style: TextStyle(
                        fontSize: 22,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    Text(
                      'Tap + to add your first task.',

                      style: TextStyle(
                        color:
                        Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              );
            }

            // TODO LIST
            return ListView.builder(

              padding:
              const EdgeInsets.all(16),

              itemCount:
              todos.length,

              itemBuilder:
                  (context, index) {

                return buildTodoCard(
                  todos[index],
                );
              },
            );
          },
        ),
      ),

      floatingActionButton:
      FloatingActionButton.extended(

        onPressed:
        showAddTodoDialog,

        icon:
        const Icon(Icons.add),

        label:
        const Text('Add TODO'),
      ),
    );
  }
}