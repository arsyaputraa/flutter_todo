import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/blocs/get_todo/get_todo_bloc.dart';
import 'package:flutter_todo/screens/auth/blocs/sign_in/sign_in_bloc.dart';
import 'package:flutter_todo/screens/edit_todo/blocs/set_todo/set_todo_bloc.dart';
import 'package:flutter_todo/screens/edit_todo/edit_screen.dart';
import 'package:flutter_todo/screens/history/history_screen.dart';
import 'package:flutter_todo/screens/home/blocs/delete_todo/delete_todo_bloc.dart';
import 'package:flutter_todo/screens/input_todo/blocs/add_todo/add_todo_bloc.dart';
import 'package:flutter_todo/screens/input_todo/input_screens.dart';
import 'package:flutter_todo/util/util.dart';
import 'package:todo_repository/todo_repository.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<DeleteTodoBloc, DeleteTodoState>(
          listener: (context, state) {
            if (state is DeleteTodoSuccess) {
              context.read<GetTodoBloc>().add(GetTodoList());
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  content: const Text('Data deleted'),
                ),
              );
            }

            if (state is DeleteTodoError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Theme.of(context).colorScheme.error,
                  content: Text(state.error),
                ),
              );
            }
          },
        ),
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
        BlocListener<AddTodoBloc, AddTodoState>(
          listener: (context, state) {
            if (state is AddTodoError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Theme.of(context).colorScheme.error,
                  content: Text(state.error),
                ),
              );
            }
            if (state is AddTodoSuccess) {
              context.read<GetTodoBloc>().add(GetTodoList());
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  content: const Text('Data Added'),
                ),
              );
            }
          },
        ),
        BlocListener<SetTodoBloc, SetTodoState>(
          listener: (context, state) {
            if (state is SetTodoError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Theme.of(context).colorScheme.error,
                  content: Text(state.error),
                ),
              );
            }
            if (state is SetTodoSuccess) {
              context.read<GetTodoBloc>().add(GetTodoList());
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  content: const Text('Data Edited'),
                ),
              );
            }
          },
        ),
      ],
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (innerContext) => BlocProvider.value(
                value: context.read<AddTodoBloc>(),
                child: const InputScreen(),
              ),
            );
          },
          child: const Icon(CupertinoIcons.add),
        ),
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (historyContext) => BlocProvider.value(
                      value: context.read<GetTodoBloc>()
                        ..add(
                          GetTodoHistories(),
                        ),
                      child: BlocProvider.value(
                        value: context.read<DeleteTodoBloc>(),
                        child: const HistoryScreen(),
                      ),
                    ),
                  ),
                );
              },
              iconSize: 32,
              icon: const Icon(CupertinoIcons.cube_box),
            ),
            IconButton(
              iconSize: 32,
              onPressed: () {
                context.read<SignInBloc>().add(
                      SignOutRequired(),
                    );
              },
              icon: const Icon(CupertinoIcons.arrow_right_to_line),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'All Todos',
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
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (innerEditContext) =>
                                            BlocProvider.value(
                                          value: context.read<SetTodoBloc>(),
                                          child: EditScreen(
                                            initialTodo: todo,
                                          ),
                                        ),
                                      );
                                    },
                                    icon: const Icon(CupertinoIcons.pencil),
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      context
                                          .read<DeleteTodoBloc>()
                                          .add(DeleteTodo(todo: todo));
                                    },
                                    icon: const Icon(CupertinoIcons.trash),
                                    color: Colors.red,
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
