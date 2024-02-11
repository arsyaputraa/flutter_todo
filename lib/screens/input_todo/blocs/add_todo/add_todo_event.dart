part of 'add_todo_bloc.dart';

sealed class AddTodoEvent extends Equatable {
  const AddTodoEvent();

  @override
  List<Object> get props => [];
}

class AddTodo extends AddTodoEvent {
  final Todo newTodo;

  const AddTodo({required this.newTodo});
}
