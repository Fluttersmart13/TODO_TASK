import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/moor_db/database_helpers.dart';

import '../../repository/to_do_repository.dart';
import '../states/todo_state.dart';

class TommorrowCubit extends Cubit<ToDoState> {
  final Repository repository;
  TommorrowCubit({required this.repository})
      : super(ToDoState(isLoading: true, task: []));
  void load() async {
    emit(ToDoState(isLoading: true, task: []));
    try {
      List<DBTask> categories = await this.repository.getData("tomorrow");
      emit(ToDoState(task: categories, isFailed: false));
    } catch (e) {
      emit(ToDoState(isFailed: true, task: []));
    }
  }
}
