part of 'get_todo_bloc.dart';

sealed class GetTodoEvent extends Equatable {
  const GetTodoEvent();

  @override
  List<Object> get props => [];
}

class GetTodoList extends GetTodoEvent {}

class GetTodoHistories extends GetTodoEvent {}
