class TodoModel {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;

  TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
  });

  // Firestore data ko TodoModel me convert karna
  factory TodoModel.fromMap(
      String id,
      Map<String, dynamic> data,
      ) {
    return TodoModel(
      id: id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      isCompleted: data['isCompleted'] ?? false,
    );
  }

  // TodoModel ko Firestore data me convert karna
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
    };
  }
}