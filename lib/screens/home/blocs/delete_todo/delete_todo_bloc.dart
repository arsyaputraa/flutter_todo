import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_repository/todo_repository.dart';

part 'delete_todo_event.dart';
part 'delete_todo_state.dart';

class DeleteTodoBloc extends Bloc<DeleteTodoEvent, DeleteTodoState> {
  final TodoRepository _todoRepository;

  DeleteTodoBloc(this._todoRepository) : super(DeleteTodoInitial()) {
    on<DeleteTodo>((DeleteTodo event, emit) async {
      emit(DeleteTodoLoading());
      try {
        await _todoRepository.deleteTodo(event.todo);
        emit(DeleteTodoSuccess());
      } on FirebaseException catch (e) {
        emit(DeleteTodoError(error: e.message.toString()));
      } catch (e) {
        emit(DeleteTodoError(error: e.toString()));
      }
    });

    on<RestoreTodo>((RestoreTodo event, emit) async {
      emit(DeleteTodoLoading());
      try {
        await _todoRepository.restoreTodo(event.todo);
        emit(DeleteTodoSuccess());
      } on FirebaseException catch (e) {
        emit(DeleteTodoError(error: e.message.toString()));
      } catch (e) {
        emit(DeleteTodoError(error: e.toString()));
      }
    });
  }
}
