import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_repository/todo_repository.dart';

part 'get_todo_event.dart';
part 'get_todo_state.dart';

class GetTodoBloc extends Bloc<GetTodoEvent, GetTodoState> {
  final TodoRepository _todoRepository;
  GetTodoBloc(this._todoRepository) : super(GetTodoInitial()) {
    on<GetTodoList>((GetTodoList event, emit) async {
      emit(GetTodoLoading());
      try {
        List<Todo> data = await _todoRepository.getTodo();
        emit(GetTodoSuccess(data: data));
      } on FirebaseException catch (e) {
        emit(GetTodoError(error: e.message.toString()));
      } catch (e) {
        emit(GetTodoError(error: e.toString()));
      }
    });

    on<GetTodoHistories>((GetTodoHistories event, emit) async {
      emit(GetTodoLoading());
      try {
        List<Todo> data = await _todoRepository.getTodoHistories();
        emit(GetTodoSuccess(data: data));
      } on FirebaseException catch (e) {
        emit(GetTodoError(error: e.message.toString()));
      } catch (e) {
        emit(GetTodoError(error: e.toString()));
      }
    });
  }
}
