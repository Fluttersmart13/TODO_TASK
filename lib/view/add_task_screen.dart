import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/logic/cubit/add_task_bloc.dart';
import 'package:to_do/logic/events/task_events.dart';
import 'package:to_do/logic/states/task_state.dart';
import 'package:to_do/main.dart';
import 'package:uuid/uuid.dart';

class AddTaskScreen extends StatefulWidget {
  final String type;
  final String title;
  final String description;

  const AddTaskScreen({
    super.key,
    required this.type,
    required this.title,
    required this.description,
  });
  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController title = new TextEditingController();
  TextEditingController description = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(50),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Add task for ${widget.type}",
                style: textStyle(30.0, FontWeight.bold, Colors.black),
              ),
              Text(
                "Please add your task",
                style: textStyle(16.0, FontWeight.normal, Colors.grey),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Title ",
                style: textStyle(20.0, FontWeight.bold, Colors.black),
              ),
              Container(
                child: TextFormField(
                  controller: title,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Title of Task';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  enableSuggestions: false,
                  autocorrect: false,
                  obscureText: false,
                  onChanged: (value) {
                    BlocProvider.of<AddTaskBloc>(context)
                        .add(TextChangeEvent(title.text, description.text));
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter Title',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Description ",
                    style: textStyle(20.0, FontWeight.bold, Colors.black),
                  ),
                  Text(
                    "*",
                    style: textStyle(20.0, FontWeight.bold, Colors.red),
                  ),
                ],
              ),
              Container(
                child: TextFormField(
                  controller: description,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Description';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  enableSuggestions: false,
                  autocorrect: false,
                  obscureText: false,
                  onChanged: (value) {
                    BlocProvider.of<AddTaskBloc>(context)
                        .add(TextChangeEvent(title.text, description.text));
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter Description',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ),
              BlocBuilder<AddTaskBloc, TaskState>(
                builder: (context, state) {
                  if (state is ErrorState) {
                    return Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Text(
                        state.errorMessage,
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              submitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget submitButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: BlocBuilder<AddTaskBloc, TaskState>(
        builder: (context, state) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor:
                    state is ValidState ? Colors.blue : Colors.grey,
                // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: TextStyle(
                    // fontSize: 30,
                    fontWeight: FontWeight.bold)),
            child: Text(
              'ADD',
              style: TextStyle(fontSize: 20.0),
            ),
            onPressed: () {
              if (state is ValidState) {
                String uuid = const Uuid().v1().toString();
                BlocProvider.of<AddTaskBloc>(context).add(SubmittedEvent(
                    title.text, description.text, widget.type!, uuid));
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (builder) => MyApp()),
                  (route) => false,
                );
              }
            },
          );
        },
      ),
    );
  }

  textStyle(double fontsize, FontWeight fontw, Color colors) {
    return TextStyle(fontSize: fontsize, fontWeight: fontw, color: colors);
  }
}
