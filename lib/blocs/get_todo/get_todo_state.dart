part of 'get_todo_bloc.dart';

sealed class GetTodoState extends Equatable {
  const GetTodoState();

  @override
  List<Object> get props => [];
}

final class GetTodoInitial extends GetTodoState {}

final class GetTodoSuccess extends GetTodoState {
  final List<Todo> data;
  const GetTodoSuccess({required this.data});
}

final class GetTodoError extends GetTodoState {
  final String error;

  const GetTodoError({required this.error});
}

final class GetTodoLoading extends GetTodoState {}
