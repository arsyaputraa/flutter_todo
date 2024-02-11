part of 'add_todo_bloc.dart';

sealed class AddTodoState extends Equatable {
  const AddTodoState();

  @override
  List<Object> get props => [];
}

final class AddTodoInitial extends AddTodoState {}

final class AddTodoSuccess extends AddTodoState {}

final class AddTodoLoading extends AddTodoState {}

final class AddTodoError extends AddTodoState {
  final String error;

  const AddTodoError({required this.error});
}
