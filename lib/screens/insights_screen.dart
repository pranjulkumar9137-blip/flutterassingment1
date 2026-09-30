import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/task_provider.dart';

class InsightsScreen
    extends StatelessWidget {

  const InsightsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Consumer<TaskProvider>(
      builder: (
          context,
          provider,
          child,
          ) {

        final rate =
            provider.completionRate;

        return SafeArea(
          child: ListView(
            padding:
            const EdgeInsets.all(20),

            children: [

              const Text(
                'Insights',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight:
                  FontWeight.w800,
                ),
              ),

              const SizedBox(
                height: 6,
              ),

              Text(
                'A quick look at your productivity.',
                style: TextStyle(
                  color:
                  Colors.grey.shade600,
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              Container(
                padding:
                const EdgeInsets.all(24),

                decoration:
                BoxDecoration(
                  color:
                  Colors.white,
                  borderRadius:
                  BorderRadius.circular(
                    26,
                  ),
                ),

                child: Column(
                  children: [

                    TweenAnimationBuilder<double>(
                      tween:
                      Tween(
                        begin: 0,
                        end: rate,
                      ),

                      duration:
                      const Duration(
                        milliseconds: 1000,
                      ),

                      builder: (
                          context,
                          value,
                          child,
                          ) {

                        return SizedBox(
                          width: 150,
                          height: 150,

                          child: Stack(
                            alignment:
                            Alignment.center,

                            children: [

                              CircularProgressIndicator(
                                value: value,
                                strokeWidth: 13,
                                backgroundColor:
                                Theme.of(
                                  context,
                                )
                                    .colorScheme
                                    .surfaceContainerHighest,
                              ),

                              Column(
                                mainAxisSize:
                                MainAxisSize.min,

                                children: [

                                  Text(
                                    '${(value * 100).round()}%',
                                    style:
                                    const TextStyle(
                                      fontSize: 32,
                                      fontWeight:
                                      FontWeight.w900,
                                    ),
                                  ),

                                  Text(
                                    'complete',
                                    style:
                                    TextStyle(
                                      color:
                                      Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    const SizedBox(
                      height: 22,
                    ),

                    Text(
                      provider.completedCount ==
                          0
                          ? 'Start with one small task.'
                          : provider.pendingCount ==
                          0
                          ? 'Amazing! Everything is complete. 🎉'
                          : 'Keep going — every completed task counts!',

                      textAlign:
                      TextAlign.center,

                      style:
                      const TextStyle(
                        fontSize: 18,
                        fontWeight:
                        FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 18,
              ),

              Row(
                children: [

                  Expanded(
                    child:
                    _StatCard(
                      icon:
                      Icons.list_alt,
                      title:
                      'Total',
                      value:
                      '${provider.totalCount}',
                    ),
                  ),

                  const SizedBox(
                    width: 12,
                  ),

                  Expanded(
                    child:
                    _StatCard(
                      icon:
                      Icons.check_circle,
                      title:
                      'Done',
                      value:
                      '${provider.completedCount}',
                    ),
                  ),

                  const SizedBox(
                    width: 12,
                  ),

                  Expanded(
                    child:
                    _StatCard(
                      icon:
                      Icons.pending_actions,
                      title:
                      'Pending',
                      value:
                      '${provider.pendingCount}',
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 24,
              ),

              const Text(
                'Category overview',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight:
                  FontWeight.w800,
                ),
              ),

              const SizedBox(
                height: 12,
              ),

              ...provider.categories
                  .where(
                    (c) => c != 'All',
              )
                  .map(
                    (category) {

                  final count =
                      provider.tasks
                          .where(
                            (task) =>
                        task.category ==
                            category,
                      )
                          .length;

                  return Padding(
                    padding:
                    const EdgeInsets.only(
                      bottom: 10,
                    ),

                    child: ListTile(
                      tileColor:
                      Colors.white,

                      shape:
                      RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(
                          17,
                        ),
                      ),

                      leading:
                      CircleAvatar(
                        child:
                        Text('$count'),
                      ),

                      title:
                      Text(category),

                      trailing:
                      const Icon(
                        Icons.chevron_right,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _StatCard
    extends StatelessWidget {

  final IconData icon;
  final String title;
  final String value;

  const _StatCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(
      BuildContext context) {

    return Container(
      padding:
      const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 8,
      ),

      decoration:
      BoxDecoration(
        color:
        Colors.white,
        borderRadius:
        BorderRadius.circular(
          20,
        ),
      ),

      child: Column(
        children: [

          Icon(
            icon,
            color:
            Theme.of(context)
                .colorScheme
                .primary,
          ),

          const SizedBox(
            height: 8,
          ),

          Text(
            value,
            style:
            const TextStyle(
              fontSize: 22,
              fontWeight:
              FontWeight.w900,
            ),
          ),

          Text(
            title,
            style: TextStyle(
              color:
              Colors.grey.shade600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}