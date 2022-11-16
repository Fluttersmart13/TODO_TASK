import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/moor_db/database_helpers.dart';

import '../../repository/to_do_repository.dart';
import '../states/todo_state.dart';

class UpcomingCubit extends Cubit<ToDoState> {
  final Repository repository;
  UpcomingCubit({required this.repository})
      : super(ToDoState(isLoading: true, task: []));
  void load() async {
    emit(ToDoState(isLoading: true, task: []));
    try {
      List<DBTask> task = await this.repository.getData("upcoming");
      emit(ToDoState(task: task, isFailed: false));
    } catch (e) {
      emit(ToDoState(isFailed: true, task: []));
    }
  }
}
