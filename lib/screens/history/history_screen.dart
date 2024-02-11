import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/blocs/get_todo/get_todo_bloc.dart';
import 'package:flutter_todo/screens/home/blocs/delete_todo/delete_todo_bloc.dart';
import 'package:flutter_todo/util/util.dart';
import 'package:todo_repository/todo_repository.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<GetTodoBloc, GetTodoState>(
          listener: (context, state) {
            if (state is GetTodoError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Theme.of(context).colorScheme.error,
                  content: Text(state.error),
                ),
              );
            }
          },
        ),
        BlocListener<DeleteTodoBloc, DeleteTodoState>(
          listener: (context, state) {
            if (state is DeleteTodoError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Theme.of(context).colorScheme.error,
                  content: Text(state.error),
                ),
              );
            }
            if (state is DeleteTodoSuccess) {
              context.read<GetTodoBloc>().add(GetTodoHistories());
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                context.read<GetTodoBloc>().add(GetTodoList());
                Navigator.of(context).pop();
              },
              icon: const Icon(
                CupertinoIcons.chevron_back,
                size: 30,
              )),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Histories',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(child: BlocBuilder<GetTodoBloc, GetTodoState>(
                builder: (context, state) {
                  if (state is GetTodoSuccess) {
                    if (state.data.isEmpty) {
                      return const Center(child: Text('There is no data'));
                    } else {
                      return ListView.builder(
                        itemCount: state.data.length,
                        itemBuilder: (context, index) {
                          Todo todo = state.data[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 15.0,
                                horizontal: 20,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          todo.title.trim(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20,
                                            decoration: todo.isDone
                                                ? TextDecoration.lineThrough
                                                : TextDecoration.none,
                                          ),
                                        ),
                                        Text(parseTodoDate(todo.dueDate)),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      context
                                          .read<DeleteTodoBloc>()
                                          .add(RestoreTodo(todo: todo));
                                    },
                                    icon: const Icon(CupertinoIcons.restart),
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  } else if (state is GetTodoLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return const Center(
                      child: Text('An error has occured'),
                    );
                  }
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
