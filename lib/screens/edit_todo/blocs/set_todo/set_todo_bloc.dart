import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_repository/todo_repository.dart';

part 'set_todo_event.dart';
part 'set_todo_state.dart';

class SetTodoBloc extends Bloc<SetTodoEvent, SetTodoState> {
  final TodoRepository _todoRepository;

  SetTodoBloc(this._todoRepository) : super(SetTodoInitial()) {
    on<SetTodo>((SetTodo event, emit) async {
      emit(SetTodoLoading());
      try {
        await _todoRepository.setTodo(event.newTodo);
        emit(SetTodoSuccess());
      } on FirebaseAuthException catch (e) {
        emit(
          SetTodoError(
            error: e.message.toString(),
          ),
        );
      } catch (e) {
        emit(
          SetTodoError(
            error: e.toString(),
          ),
        );
      }
    });
  }
}
