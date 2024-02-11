part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthEventUserAuthChange extends AuthEvent {
  final User? user;

  const AuthEventUserAuthChange({this.user});
}
