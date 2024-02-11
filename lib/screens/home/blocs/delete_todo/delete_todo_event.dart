part of 'delete_todo_bloc.dart';

sealed class DeleteTodoEvent extends Equatable {
  const DeleteTodoEvent();

  @override
  List<Object> get props => [];
}

class DeleteTodo extends DeleteTodoEvent {
  final Todo todo;

  const DeleteTodo({required this.todo});
}

class RestoreTodo extends DeleteTodoEvent {
  final Todo todo;

  const RestoreTodo({required this.todo});
}
