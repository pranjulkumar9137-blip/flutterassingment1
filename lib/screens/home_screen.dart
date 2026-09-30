import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/task_provider.dart';
import '../widgets/task_card.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String greeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good morning';
    }

    if (hour < 17) {
      return 'Good afternoon';
    }

    return 'Good evening';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (
          context,
          provider,
          child,
          ) {
        final now = DateTime.now();

        final todayTasks =
        provider.tasks.where((task) {
          return task.dueDate.year == now.year &&
              task.dueDate.month == now.month &&
              task.dueDate.day == now.day;
        }).toList();

        return SafeArea(
          child: CustomScrollView(
            slivers: [

              SliverPadding(
                padding:
                const EdgeInsets.fromLTRB(
                  20,
                  20,
                  20,
                  0,
                ),

                sliver:
                SliverToBoxAdapter(
                  child: Row(
                    children: [

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [

                            Text(
                              greeting(),
                              style: TextStyle(
                                color:
                                Colors.grey.shade600,
                                fontSize: 15,
                              ),
                            ),

                            const SizedBox(
                              height: 4,
                            ),

                            const Text(
                              "Let's get things done.",
                              style: TextStyle(
                                fontSize: 27,
                                fontWeight:
                                FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),

                      CircleAvatar(
                        radius: 25,
                        backgroundColor:
                        Theme.of(context)
                            .colorScheme
                            .primaryContainer,
                        child: Icon(
                          Icons.person,
                          color:
                          Theme.of(context)
                              .colorScheme
                              .primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SliverPadding(
                padding:
                const EdgeInsets.all(20),
                sliver:
                SliverToBoxAdapter(
                  child:
                  _ProgressCard(
                    provider: provider,
                  ),
                ),
              ),

              SliverPadding(
                padding:
                const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                sliver:
                SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,
                    children: [

                      const Text(
                        'Today',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight:
                          FontWeight.w800,
                        ),
                      ),

                      Text(
                        '${todayTasks.length} tasks',
                        style: TextStyle(
                          color:
                          Colors.grey.shade600,
                          fontWeight:
                          FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SliverPadding(
                padding:
                const EdgeInsets.fromLTRB(
                  20,
                  14,
                  20,
                  100,
                ),

                sliver:
                todayTasks.isEmpty
                    ? SliverToBoxAdapter(
                  child:
                  _EmptyToday(
                    onAdd: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                          const AddTaskScreen(),
                        ),
                      );
                    },
                  ),
                )
                    : SliverList.builder(
                  itemCount:
                  todayTasks.length,
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
                        todayTasks[
                        index],
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

class _ProgressCard
    extends StatelessWidget {

  final TaskProvider provider;

  const _ProgressCard({
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {

    final percent =
        provider.completionRate;

    return TweenAnimationBuilder<double>(
      tween: Tween(
        begin: 0,
        end: percent,
      ),
      duration:
      const Duration(milliseconds: 900),

      curve: Curves.easeOutCubic,

      builder: (
          context,
          value,
          child,
          ) {
        return Container(
          padding:
          const EdgeInsets.all(22),

          decoration:
          BoxDecoration(
            gradient:
            LinearGradient(
              colors: [
                Theme.of(context)
                    .colorScheme
                    .primary,
                Theme.of(context)
                    .colorScheme
                    .secondary,
              ],
            ),
            borderRadius:
            BorderRadius.circular(28),
          ),

          child: Row(
            children: [

              SizedBox(
                width: 92,
                height: 92,

                child: Stack(
                  alignment:
                  Alignment.center,

                  children: [

                    CircularProgressIndicator(
                      value: value,
                      strokeWidth: 9,
                      backgroundColor:
                      Colors.white24,
                      valueColor:
                      const AlwaysStoppedAnimation<
                          Color>(
                        Colors.white,
                      ),
                    ),

                    Text(
                      '${(value * 100).round()}%',
                      style:
                      const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight:
                        FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                width: 20,
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    const Text(
                      'Your progress',
                      style: TextStyle(
                        color:
                        Colors.white70,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(
                      height: 5,
                    ),

                    Text(
                      provider.completedCount ==
                          provider.totalCount &&
                          provider.totalCount >
                              0
                          ? 'All done! 🎉'
                          : '${provider.pendingCount} tasks left',

                      style:
                      const TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight:
                        FontWeight.w800,
                      ),
                    ),

                    const SizedBox(
                      height: 6,
                    ),

                    Text(
                      '${provider.completedCount} completed out of ${provider.totalCount}',
                      style:
                      const TextStyle(
                        color:
                        Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _EmptyToday
    extends StatelessWidget {

  final VoidCallback onAdd;

  const _EmptyToday({
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
      const EdgeInsets.all(30),

      margin:
      const EdgeInsets.only(top: 10),

      decoration:
      BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(24),
      ),

      child: Column(
        children: [

          const Text(
            '✨',
            style:
            TextStyle(fontSize: 45),
          ),

          const SizedBox(
            height: 12,
          ),

          const Text(
            'Your day is clear',
            style: TextStyle(
              fontSize: 20,
              fontWeight:
              FontWeight.w800,
            ),
          ),

          const SizedBox(
            height: 6,
          ),

          Text(
            'Add a task and start your next win.',
            textAlign:
            TextAlign.center,
            style: TextStyle(
              color:
              Colors.grey.shade600,
            ),
          ),

          const SizedBox(
            height: 18,
          ),

          FilledButton.icon(
            onPressed: onAdd,
            icon:
            const Icon(Icons.add),
            label:
            const Text('Add Task'),
          ),
        ],
      ),
    );
  }
}