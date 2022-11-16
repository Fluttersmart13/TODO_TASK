import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/logic/cubit/update_task_bloc.dart';
import 'package:to_do/logic/events/task_events.dart';
import 'package:to_do/logic/states/task_state.dart';
import 'package:to_do/main.dart';

class UpdateTaskScreen extends StatefulWidget {
  final String type;
  final String title;
  final String description;
  final String iid;

  const UpdateTaskScreen(
      {super.key,
      required this.type,
      required this.title,
      required this.description,
      required this.iid});
  @override
  State<UpdateTaskScreen> createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends State<UpdateTaskScreen> {
  TextEditingController title = new TextEditingController();
  TextEditingController description = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    title.text = widget.title;
    description.text = widget.description;

    BlocProvider.of<UpdateTaskBloc>(context)
        .add(TextChangeEvent(title.text, description.text));
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
              const SizedBox(
                height: 30,
              ),
              Text(
                "Title ",
                style: textStyle(20.0, FontWeight.bold, Colors.black),
              ),
              TextFormField(
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
                  BlocProvider.of<UpdateTaskBloc>(context)
                      .add(TextChangeEvent(title.text, description.text));
                },
                decoration: InputDecoration(
                  hintText: 'Enter Title',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
              const SizedBox(
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
              TextFormField(
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
                  BlocProvider.of<UpdateTaskBloc>(context)
                      .add(TextChangeEvent(title.text, description.text));
                },
                decoration: InputDecoration(
                  hintText: 'Enter Description',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
              BlocBuilder<UpdateTaskBloc, TaskState>(
                builder: (context, state) {
                  if (state is ErrorState) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Text(
                        state.errorMessage,
                        style: const TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
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
      child: BlocBuilder<UpdateTaskBloc, TaskState>(
        builder: (context, state) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor:
                    state is ValidState ? Colors.blue : Colors.grey,
                // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: const TextStyle(
                    // fontSize: 30,
                    fontWeight: FontWeight.bold)),
            child: const Text(
              'Update',
              style: TextStyle(fontSize: 20.0),
            ),
            onPressed: () {
              if (state is ValidState) {
                BlocProvider.of<UpdateTaskBloc>(context).add(SubmittedEvent(
                    title.text, description.text, widget.type!, widget.iid));
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
