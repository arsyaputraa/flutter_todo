import 'package:equatable/equatable.dart';

class MyUser extends Equatable {
  final String email;
  final String name;
  final String userId;

  const MyUser({
    required this.email,
    required this.name,
    required this.userId,
  });

  factory MyUser.fromJson(Map<String, dynamic> json) => MyUser(
        email: json["email"],
        name: json["name"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "userId": userId,
      };

  MyUser copyWith({
    String? email,
    String? name,
    String? userId,
  }) =>
      MyUser(
        email: email ?? this.email,
        name: name ?? this.name,
        userId: userId ?? this.userId,
      );

  static const empty = MyUser(email: "", name: "", userId: "");

  @override
  List<Object?> get props => [userId, email, name];
}
