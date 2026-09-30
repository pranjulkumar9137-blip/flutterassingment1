import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final DateTime? reminderAt;

  TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    this.reminderAt,
  });

  factory TodoModel.fromMap(
      String id,
      Map<String, dynamic> map,
      ) {
    DateTime? reminder;

    if (map['reminderAt'] != null) {
      reminder = (map['reminderAt'] as Timestamp).toDate();
    }

    return TodoModel(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      isCompleted: map['isCompleted'] ?? false,
      reminderAt: reminder,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'reminderAt':
      reminderAt == null ? null : Timestamp.fromDate(reminderAt!),
    };
  }

  TodoModel copyWith({
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? reminderAt,
    bool removeReminder = false,
  }) {
    return TodoModel(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      reminderAt:
      removeReminder ? null : (reminderAt ?? this.reminderAt),
    );
  }
}