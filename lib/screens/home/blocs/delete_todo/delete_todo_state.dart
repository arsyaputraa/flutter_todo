part of 'delete_todo_bloc.dart';

sealed class DeleteTodoState extends Equatable {
  const DeleteTodoState();

  @override
  List<Object> get props => [];
}

final class DeleteTodoInitial extends DeleteTodoState {}

final class DeleteTodoSuccess extends DeleteTodoState {}

final class DeleteTodoError extends DeleteTodoState {
  final String error;

  const DeleteTodoError({required this.error});
}

final class DeleteTodoLoading extends DeleteTodoState {}
