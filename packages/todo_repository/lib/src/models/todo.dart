import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String todoId;
  final String title;
  final bool isDone;
  final DateTime dueDate;
  final bool isActive;

  const Todo({
    required this.todoId,
    required this.title,
    required this.isDone,
    required this.dueDate,
    required this.isActive,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      todoId: json['todoId'],
      title: json['title'],
      isDone: json['isDone'],
      dueDate: (json['dueDate'] as Timestamp).toDate(),
      isActive: json['isActive'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'todoId': todoId,
      'title': title,
      'isDone': isDone,
      'dueDate': Timestamp.fromDate(dueDate),
      'isActive': isActive,
    };
  }

  Todo copyWith({
    String? todoId,
    String? title,
    bool? isDone,
    DateTime? dueDate,
    bool? isActive,
  }) =>
      Todo(
        todoId: todoId ?? this.todoId,
        title: title ?? this.title,
        isDone: isDone ?? this.isDone,
        dueDate: dueDate ?? this.dueDate,
        isActive: isActive ?? this.isActive,
      );

  static Todo empty = Todo(
    todoId: '',
    title: '',
    isDone: false,
    dueDate: DateTime.now(),
    isActive: true,
  );

  @override
  List<Object?> get props => [todoId, title, isDone, dueDate, isActive];
}
