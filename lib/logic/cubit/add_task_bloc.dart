import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/logic/events/task_events.dart';
import 'package:to_do/logic/states/task_state.dart';
import 'package:to_do/moor_db/database_helpers.dart';

class AddTaskBloc extends Bloc<TaskEvent, TaskState> {
  final _databaseInstance = AppDatabase.sharedInstance;
  AddTaskBloc() : super(InitialState()) {
    on<TextChangeEvent>((event, emit) => {
          if (event.title == "")
            {emit(ErrorState("Please Enter title"))}
          else if (event.description.length < 2)
            {emit(ErrorState("Description can not be empty"))}
          else
            {
              {emit(ValidState())}
            }
        });
    DBTask task;

    on<SubmittedEvent>((event, emit) async => {
          print(event.iid.runtimeType),
          task = DBTask(
              Title: event.title,
              Description: event.description,
              type: event.type,
              id: event.iid.toString()),
          TasksDao(_databaseInstance).addTask(task),
          emit(ApiSuccessState())
        });
  }
}
