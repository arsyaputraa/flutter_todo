import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/todo.dart';
import 'todo_repo.dart';

class FirebaseTodoRepo implements TodoRepository {
  final todoCollections = FirebaseFirestore.instance.collection('todos');

  @override
  Future<List<Todo>> getTodo() async {
    try {
      return await todoCollections
          .where('isActive', isEqualTo: true)
          .get()
          .then(
            (value) => value.docs
                .map(
                  (e) => Todo.fromJson(
                    e.data(),
                  ),
                )
                .toList(),
          );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Todo>> getTodoHistories() async {
    try {
      return await todoCollections
          .where('isActive', isEqualTo: false)
          .get()
          .then(
            (value) => value.docs
                .map(
                  (e) => Todo.fromJson(
                    e.data(),
                  ),
                )
                .toList(),
          );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<Todo> addTodo(Todo todo) async {
    try {
      // UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
      //     email: myUser.email, password: password);

      DocumentReference myTodo = await todoCollections.add(todo.toJson());

      return todo.copyWith(todoId: myTodo.id);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> deleteTodo(Todo todo) async {
    try {
      await todoCollections.doc(todo.todoId).update({'isActive': false});
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> setTodo(Todo todo) async {
    try {
      await todoCollections.doc(todo.todoId).set(todo.toJson());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> restoreTodo(Todo todo) async {
    try {
      await todoCollections.doc(todo.todoId).update({'isActive': true});
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
