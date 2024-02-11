import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_repository/todo_repository.dart';

part 'add_todo_event.dart';
part 'add_todo_state.dart';

class AddTodoBloc extends Bloc<AddTodoEvent, AddTodoState> {
  final TodoRepository _todoRepository;
  AddTodoBloc(this._todoRepository) : super(AddTodoInitial()) {
    on<AddTodo>(
      (AddTodo event, emit) async {
        emit(AddTodoLoading());
        try {
          Todo newTodo = await _todoRepository.addTodo(event.newTodo);
          await _todoRepository.setTodo(newTodo);
          emit(AddTodoSuccess());
        } on FirebaseAuthException catch (e) {
          emit(
            AddTodoError(
              error: e.message.toString(),
            ),
          );
        } catch (e) {
          emit(
            AddTodoError(
              error: e.toString(),
            ),
          );
        }
      },
    );
  }
}
