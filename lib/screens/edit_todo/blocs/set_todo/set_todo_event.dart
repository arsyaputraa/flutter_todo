part of 'set_todo_bloc.dart';

sealed class SetTodoEvent extends Equatable {
  const SetTodoEvent();

  @override
  List<Object> get props => [];
}

class SetTodo extends SetTodoEvent {
  final Todo newTodo;

  const SetTodo({required this.newTodo});
}
