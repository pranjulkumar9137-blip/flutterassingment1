import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../providers/task_provider.dart';
import '../screens/add_task_screen.dart';

class TaskCard
    extends StatelessWidget {

  final Task task;

  const TaskCard({
    super.key,
    required this.task,
  });

  Color priorityColor(
      BuildContext context) {

    switch (task.priority) {
      case TaskPriority.high:
        return Colors.red;

      case TaskPriority.medium:
        return Colors.orange;

      case TaskPriority.low:
        return Colors.green;
    }
  }

  @override
  Widget build(
      BuildContext context) {

    final color =
    priorityColor(context);

    return Dismissible(
      key:
      ValueKey(task.id),

      direction:
      DismissDirection.endToStart,

      background: Container(
        alignment:
        Alignment.centerRight,

        padding:
        const EdgeInsets.only(
          right: 24,
        ),

        decoration:
        BoxDecoration(
          color:
          Colors.red.shade100,
          borderRadius:
          BorderRadius.circular(
            22,
          ),
        ),

        child: const Icon(
          Icons.delete_outline,
          color:
          Colors.red,
        ),
      ),

      onDismissed: (_) {

        context
            .read<TaskProvider>()
            .deleteTask(
          task.id,
        );

        ScaffoldMessenger.of(context)
            .showSnackBar(
          const SnackBar(
            content:
            Text('Task deleted'),
          ),
        );
      },

      child: Card(
        child: InkWell(
          borderRadius:
          BorderRadius.circular(
            22,
          ),

          onTap: () {

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    AddTaskScreen(
                      task: task,
                    ),
              ),
            );
          },

          child: Padding(
            padding:
            const EdgeInsets.all(15),

            child: Row(
              children: [

                GestureDetector(
                  onTap: () {

                    context
                        .read<
                        TaskProvider>()
                        .toggleTask(
                      task.id,
                    );
                  },

                  child:
                  AnimatedContainer(
                    duration:
                    const Duration(
                      milliseconds: 250,
                    ),

                    width: 30,
                    height: 30,

                    decoration:
                    BoxDecoration(
                      color:
                      task.completed
                          ? Theme.of(
                        context,
                      )
                          .colorScheme
                          .primary
                          : Colors.transparent,

                      shape:
                      BoxShape.circle,

                      border:
                      Border.all(
                        color:
                        task.completed
                            ? Theme.of(
                          context,
                        )
                            .colorScheme
                            .primary
                            : Colors
                            .grey
                            .shade400,

                        width: 2,
                      ),
                    ),

                    child: task.completed
                        ? const Icon(
                      Icons.check,
                      size: 19,
                      color:
                      Colors.white,
                    )
                        : null,
                  ),
                ),

                const SizedBox(
                  width: 14,
                ),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                    children: [

                      Text(
                        task.title,

                        maxLines: 1,

                        overflow:
                        TextOverflow
                            .ellipsis,

                        style:
                        TextStyle(
                          fontSize: 16,
                          fontWeight:
                          FontWeight.w800,

                          decoration:
                          task.completed
                              ? TextDecoration
                              .lineThrough
                              : null,

                          color:
                          task.completed
                              ? Colors.grey
                              : null,
                        ),
                      ),

                      if (task
                          .description
                          .isNotEmpty) ...[

                        const SizedBox(
                          height: 4,
                        ),

                        Text(
                          task.description,

                          maxLines: 1,

                          overflow:
                          TextOverflow
                              .ellipsis,

                          style:
                          TextStyle(
                            color:
                            Colors.grey
                                .shade600,
                          ),
                        ),
                      ],

                      const SizedBox(
                        height: 8,
                      ),

                      Row(
                        children: [

                          _MiniTag(
                            icon:
                            Icons
                                .folder_outlined,
                            text:
                            task.category,
                          ),

                          const SizedBox(
                            width: 8,
                          ),

                          _MiniTag(
                            icon:
                            Icons
                                .flag_outlined,
                            text:
                            task.priority.name,
                            color:
                            color,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  width: 6,
                ),

                Icon(
                  Icons.chevron_right,
                  color:
                  Colors.grey.shade400,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MiniTag
    extends StatelessWidget {

  final IconData icon;
  final String text;
  final Color? color;

  const _MiniTag({
    required this.icon,
    required this.text,
    this.color,
  });

  @override
  Widget build(
      BuildContext context) {

    final tagColor =
        color ??
            Theme.of(context)
                .colorScheme
                .primary;

    return Row(
      mainAxisSize:
      MainAxisSize.min,

      children: [

        Icon(
          icon,
          size: 14,
          color:
          tagColor,
        ),

        const SizedBox(
          width: 3,
        ),

        Text(
          text,
          style:
          TextStyle(
            fontSize: 12,
            color:
            tagColor,
            fontWeight:
            FontWeight.w700,
          ),
        ),
      ],
    );
  }
}