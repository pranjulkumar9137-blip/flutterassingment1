import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../providers/task_provider.dart';

class AddTaskScreen
    extends StatefulWidget {

  final Task? task;

  const AddTaskScreen({
    super.key,
    this.task,
  });

  @override
  State<AddTaskScreen> createState() =>
      _AddTaskScreenState();
}

class _AddTaskScreenState
    extends State<AddTaskScreen> {

  final formKey =
  GlobalKey<FormState>();

  late final TextEditingController
  titleController;

  late final TextEditingController
  descriptionController;

  String category = 'Study';

  TaskPriority priority =
      TaskPriority.medium;

  late DateTime dueDate;

  final categories = const [
    'Study',
    'Work',
    'Personal',
    'Health',
  ];

  @override
  void initState() {
    super.initState();

    final task = widget.task;

    titleController =
        TextEditingController(
          text: task?.title ?? '',
        );

    descriptionController =
        TextEditingController(
          text: task?.description ?? '',
        );

    category =
        task?.category ?? 'Study';

    priority =
        task?.priority ??
            TaskPriority.medium;

    dueDate =
        task?.dueDate ??
            DateTime.now();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> chooseDate() async {
    final selected =
    await showDatePicker(
      context: context,
      initialDate: dueDate,
      firstDate: DateTime.now(),
      lastDate:
      DateTime.now().add(
        const Duration(days: 365),
      ),
    );

    if (selected != null) {
      setState(() {
        dueDate = selected;
      });
    }
  }

  void saveTask() {
    if (!formKey.currentState!
        .validate()) {
      return;
    }

    final provider =
    context.read<TaskProvider>();

    if (widget.task == null) {
      provider.addTask(
        title:
        titleController.text.trim(),
        description:
        descriptionController.text.trim(),
        category: category,
        priority: priority,
        dueDate: dueDate,
      );
    } else {
      provider.updateTask(
        widget.task!,
        title:
        titleController.text.trim(),
        description:
        descriptionController.text.trim(),
        category: category,
        priority: priority,
        dueDate: dueDate,
      );
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    final editing =
        widget.task != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          editing
              ? 'Edit Task'
              : 'New Task',
        ),
      ),

      body: Form(
        key: formKey,

        child: ListView(
          padding:
          const EdgeInsets.all(20),

          children: [

            _SectionTitle(
              icon:
              Icons.edit_note,
              title:
              'Task details',
            ),

            const SizedBox(
              height: 12,
            ),

            TextFormField(
              controller:
              titleController,

              decoration:
              const InputDecoration(
                labelText:
                'Task title',
                hintText:
                'e.g. Finish Flutter project',
              ),

              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return
                    'Please enter a task title';
                }

                return null;
              },
            ),

            const SizedBox(
              height: 14,
            ),

            TextFormField(
              controller:
              descriptionController,

              maxLines: 4,

              decoration:
              const InputDecoration(
                labelText:
                'Description',
                hintText:
                'Add some details...',
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            _SectionTitle(
              icon:
              Icons.tune,
              title:
              'Customize',
            ),

            const SizedBox(
              height: 12,
            ),

            DropdownButtonFormField<String>(
              initialValue: category,

              decoration:
              const InputDecoration(
                labelText:
                'Category',
              ),

              items:
              categories.map(
                    (item) {
                  return DropdownMenuItem(
                    value: item,
                    child:
                    Text(item),
                  );
                },
              ).toList(),

              onChanged:
                  (value) {
                if (value != null) {
                  setState(() {
                    category =
                        value;
                  });
                }
              },
            ),

            const SizedBox(
              height: 14,
            ),

            DropdownButtonFormField<
                TaskPriority>(
              initialValue:
              priority,

              decoration:
              const InputDecoration(
                labelText:
                'Priority',
              ),

              items:
              TaskPriority.values
                  .map(
                    (item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(
                      item.name[0]
                          .toUpperCase() +
                          item.name.substring(
                            1,
                          ),
                    ),
                  );
                },
              ).toList(),

              onChanged:
                  (value) {
                if (value != null) {
                  setState(() {
                    priority =
                        value;
                  });
                }
              },
            ),

            const SizedBox(
              height: 14,
            ),

            InkWell(
              borderRadius:
              BorderRadius.circular(16),

              onTap: chooseDate,

              child: InputDecorator(
                decoration:
                const InputDecoration(
                  labelText:
                  'Due date',
                  prefixIcon:
                  Icon(
                    Icons.calendar_month,
                  ),
                ),

                child: Text(
                  '${dueDate.day.toString().padLeft(2, '0')}/'
                      '${dueDate.month.toString().padLeft(2, '0')}/'
                      '${dueDate.year}',
                ),
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            FilledButton.icon(
              onPressed:
              saveTask,

              icon: Icon(
                editing
                    ? Icons.save
                    : Icons.add_task,
              ),

              label: Text(
                editing
                    ? 'Save Changes'
                    : 'Create Task',
              ),

              style:
              FilledButton.styleFrom(
                minimumSize:
                const Size.fromHeight(
                  54,
                ),

                shape:
                RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(
                    17,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle
    extends StatelessWidget {

  final IconData icon;
  final String title;

  const _SectionTitle({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(
      BuildContext context) {

    return Row(
      children: [

        Icon(
          icon,
          color:
          Theme.of(context)
              .colorScheme
              .primary,
        ),

        const SizedBox(
          width: 8,
        ),

        Text(
          title,
          style:
          const TextStyle(
            fontSize: 18,
            fontWeight:
            FontWeight.w800,
          ),
        ),
      ],
    );
  }
}