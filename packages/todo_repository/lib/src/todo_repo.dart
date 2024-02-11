import '../todo_repository.dart';

abstract class TodoRepository {
  Future<Todo> addTodo(Todo todo);

  Future<void> deleteTodo(Todo todo);

  Future<void> restoreTodo(Todo todo);

  Future<void> setTodo(Todo todo);

  Future<List<Todo>> getTodo();

  Future<List<Todo>> getTodoHistories();
}
