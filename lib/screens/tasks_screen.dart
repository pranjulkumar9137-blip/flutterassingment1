import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/task_provider.dart';
import '../widgets/task_card.dart';
import 'add_task_screen.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (
          context,
          provider,
          child,
          ) {
        final tasks =
            provider.filteredTasks;

        return SafeArea(
          child: Column(
            children: [

              Padding(
                padding:
                const EdgeInsets.fromLTRB(
                  20,
                  20,
                  20,
                  10,
                ),

                child: Row(
                  children: [

                    const Expanded(
                      child: Text(
                        'My Tasks',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight:
                          FontWeight.w800,
                        ),
                      ),
                    ),

                    FilledButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                            const AddTaskScreen(),
                          ),
                        );
                      },
                      icon:
                      const Icon(Icons.add),
                      label:
                      const Text('Add'),
                    ),
                  ],
                ),
              ),

              Padding(
                padding:
                const EdgeInsets.symmetric(
                  horizontal: 20,
                ),

                child: TextField(
                  onChanged:
                  provider.setSearchQuery,

                  decoration:
                  const InputDecoration(
                    hintText:
                    'Search tasks...',
                    prefixIcon:
                    Icon(Icons.search),
                  ),
                ),
              ),

              const SizedBox(
                height: 12,
              ),

              SizedBox(
                height: 42,

                child: ListView(
                  padding:
                  const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),

                  scrollDirection:
                  Axis.horizontal,

                  children:
                  provider.categories
                      .map((category) {

                    final selected =
                        provider
                            .selectedCategory ==
                            category;

                    return Padding(
                      padding:
                      const EdgeInsets.only(
                        right: 8,
                      ),

                      child: ChoiceChip(
                        label:
                        Text(category),

                        selected:
                        selected,

                        onSelected: (_) {
                          provider.setCategory(
                            category,
                          );
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(
                height: 8,
              ),

              Expanded(
                child: tasks.isEmpty
                    ? Center(
                  child: Text(
                    'No tasks found',
                    style: TextStyle(
                      color:
                      Colors.grey.shade600,
                      fontSize: 17,
                    ),
                  ),
                )
                    : ListView.builder(
                  padding:
                  const EdgeInsets
                      .fromLTRB(
                    20,
                    8,
                    20,
                    30,
                  ),

                  itemCount:
                  tasks.length,

                  itemBuilder:
                      (context, index) {

                    return Padding(
                      padding:
                      const EdgeInsets
                          .only(
                        bottom: 12,
                      ),

                      child:
                      TaskCard(
                        task:
                        tasks[index],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}