import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/screens/auth/components/my_text_field.dart';
import 'package:flutter_todo/screens/input_todo/blocs/add_todo/add_todo_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_repository/todo_repository.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final TextEditingController _titleController = TextEditingController();
  DateTime _dateTime = DateTime.now();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(9)),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          const Text(
            'ADD TODO',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Form(
            key: _formKey,
            child: Expanded(
              child: ListView(
                children: [
                  MyTextField(
                    controller: _titleController,
                    hintText: 'Todo',
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Please fill in this field';
                      } else if (val.length > 20) {
                        return 'Name too long';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Material(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () {
                        pickDateTime();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 20,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                '${DateFormat('yyyy-MM-dd').format(_dateTime)} - ${_dateTime.hour} : ${_dateTime.minute}',
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                            const Icon(
                              CupertinoIcons.clock,
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Todo todoValue = Todo.empty;
                        todoValue = todoValue.copyWith(
                            dueDate: _dateTime, title: _titleController.text);
                        context
                            .read<AddTodoBloc>()
                            .add(AddTodo(newTodo: todoValue));
                        Navigator.of(context).pop();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor:
                            Theme.of(context).colorScheme.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 20)),
                    child: BlocBuilder<AddTodoBloc, AddTodoState>(
                      builder: (context, state) {
                        if (state is AddTodoLoading) {
                          return const CircularProgressIndicator();
                        } else {
                          return const Text('SUBMIT');
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 300,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<DateTime?> pickDate() => showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: _dateTime,
        lastDate: DateTime(2100),
      );

  Future<TimeOfDay?> pickTime() => showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: _dateTime.hour, minute: _dateTime.minute));

  Future pickDateTime() async {
    DateTime? date = await pickDate();
    if (date == null) return;

    TimeOfDay? time = await pickTime();
    if (time == null) return;

    final DateTime dateTimevalue =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);
    setState(() {
      _dateTime = dateTimevalue;
    });
  }
}
