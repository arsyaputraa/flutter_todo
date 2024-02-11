import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/blocs/auth/auth_bloc.dart';
import 'package:flutter_todo/blocs/get_todo/get_todo_bloc.dart';
import 'package:flutter_todo/screens/auth/auth_screen.dart';
import 'package:flutter_todo/screens/auth/blocs/sign_in/sign_in_bloc.dart';
import 'package:flutter_todo/screens/edit_todo/blocs/set_todo/set_todo_bloc.dart';
import 'package:flutter_todo/screens/home/blocs/delete_todo/delete_todo_bloc.dart';
import 'package:flutter_todo/screens/home/home_screen.dart';
import 'package:flutter_todo/screens/input_todo/blocs/add_todo/add_todo_bloc.dart';
import 'package:todo_repository/todo_repository.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.light(
            background: Colors.white,
            onBackground: Colors.black,
            primary: Colors.teal,
            onPrimary: Colors.white,
            secondary: const Color.fromARGB(255, 22, 58, 77),
            onSecondary: Colors.grey.shade100,
            tertiary: Colors.indigo,
            onTertiary: Colors.white,
            error: Colors.red,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
          )),
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state.status == AuthStatus.authenticated) {
            return MultiBlocProvider(
              providers: [
                BlocProvider<SignInBloc>(
                  create: (context) => SignInBloc(
                    userRepository: context.read<AuthBloc>().userRepository,
                  ),
                ),
                BlocProvider<GetTodoBloc>(
                  create: (context) =>
                      GetTodoBloc(FirebaseTodoRepo())..add(GetTodoList()),
                ),
                BlocProvider<DeleteTodoBloc>(
                  create: (context) => DeleteTodoBloc(FirebaseTodoRepo()),
                ),
                BlocProvider<AddTodoBloc>(
                  create: (context) => AddTodoBloc(FirebaseTodoRepo()),
                ),
                BlocProvider<SetTodoBloc>(
                  create: (context) => SetTodoBloc(FirebaseTodoRepo()),
                )
              ],
              child: const HomeScreen(),
            );
          } else {
            return const AuthScreen();
          }
        },
      ),
    );
  }
}
