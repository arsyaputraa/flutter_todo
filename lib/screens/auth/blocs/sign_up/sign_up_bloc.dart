import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/user_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserRepository _userRepository;

  SignUpBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(SignUpInitial()) {
    on<SignUpRequired>(
      (SignUpRequired event, emit) async {
        emit(SignUpLoading());
        try {
          MyUser newUser =
              await _userRepository.signUp(event.myuser, event.password);
          await _userRepository.setUserData(newUser);
          emit(SignUpSuccess());
        } on FirebaseAuthException catch (e) {
          emit(
            SignUpFailure(
              e.message.toString(),
            ),
          );
        } catch (e) {
          emit(
            SignUpFailure(
              e.toString(),
            ),
          );
        }
      },
    );
  }
}
