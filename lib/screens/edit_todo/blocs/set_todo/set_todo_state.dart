part of 'set_todo_bloc.dart';

sealed class SetTodoState extends Equatable {
  const SetTodoState();

  @override
  List<Object> get props => [];
}

final class SetTodoInitial extends SetTodoState {}

final class SetTodoSuccess extends SetTodoState {}

final class SetTodoError extends SetTodoState {
  final String error;

  const SetTodoError({required this.error});
}

final class SetTodoLoading extends SetTodoState {}
