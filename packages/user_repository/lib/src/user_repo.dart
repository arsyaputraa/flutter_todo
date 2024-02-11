import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/src/models/models.dart';

abstract class UserRepository {
  Stream<User?> get user;

  Future<MyUser> signUp(MyUser user, String password);

  Future<void> signIn(String email, String password);

  Future<void> setUserData(MyUser user);

  Future<void> signOut();
}
