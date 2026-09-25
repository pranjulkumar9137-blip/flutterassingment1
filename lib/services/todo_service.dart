import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/todo_model.dart';

class TodoService {

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  // ============================================
  // ADD TODO
  // ============================================

  Future<void> addTodo({
    required String uid,
    required String title,
    required String description,
  }) async {

    await _firestore
        .collection('users')
        .doc(uid)
        .collection('todos')
        .add({
      'title': title,
      'description': description,
      'isCompleted': false,
      'createdAt':
      FieldValue.serverTimestamp(),
    });
  }

  // ============================================
  // GET TODO LIST
  // ============================================

  Stream<List<TodoModel>> getTodos(
      String uid,
      ) {

    return _firestore
        .collection('users')
        .doc(uid)
        .collection('todos')
        .orderBy(
      'createdAt',
      descending: true,
    )
        .snapshots()
        .map((snapshot) {

      return snapshot.docs.map((doc) {

        return TodoModel.fromMap(
          doc.id,
          doc.data(),
        );

      }).toList();
    });
  }

  // ============================================
  // UPDATE TODO
  // ============================================

  Future<void> updateTodo({
    required String uid,
    required String todoId,
    required String title,
    required String description,
  }) async {

    await _firestore
        .collection('users')
        .doc(uid)
        .collection('todos')
        .doc(todoId)
        .update({
      'title': title,
      'description': description,
    });
  }

  // ============================================
  // COMPLETE / UNCOMPLETE TODO
  // ============================================

  Future<void> toggleTodo({
    required String uid,
    required String todoId,
    required bool isCompleted,
  }) async {

    await _firestore
        .collection('users')
        .doc(uid)
        .collection('todos')
        .doc(todoId)
        .update({
      'isCompleted': !isCompleted,
    });
  }

  // ============================================
  // DELETE TODO
  // ============================================

  Future<void> deleteTodo({
    required String uid,
    required String todoId,
  }) async {

    await _firestore
        .collection('users')
        .doc(uid)
        .collection('todos')
        .doc(todoId)
        .delete();
  }
}