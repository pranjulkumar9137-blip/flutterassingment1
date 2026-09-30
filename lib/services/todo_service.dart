import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/todo_model.dart';

class TodoService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  CollectionReference<Map<String, dynamic>> get _todoCollection {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('User is not logged in');
    }

    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('todos');
  }

  Future<String> addTodo(TodoModel todo) async {
    final document = await _todoCollection.add({
      ...todo.toMap(),
      'createdAt': FieldValue.serverTimestamp(),
    });

    return document.id;
  }

  Stream<List<TodoModel>> getTodos() {
    return _todoCollection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) {
        return snapshot.docs.map(
              (doc) {
            return TodoModel.fromMap(
              doc.id,
              doc.data(),
            );
          },
        ).toList();
      },
    );
  }

  Future<void> updateTodo(TodoModel todo) async {
    await _todoCollection.doc(todo.id).update(
      todo.toMap(),
    );
  }

  Future<void> toggleTodo(
      String id,
      bool isCompleted,
      ) async {
    await _todoCollection.doc(id).update({
      'isCompleted': isCompleted,
    });
  }

  Future<void> deleteTodo(String id) async {
    await _todoCollection.doc(id).delete();
  }
}