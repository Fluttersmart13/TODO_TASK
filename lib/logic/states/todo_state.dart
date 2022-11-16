import 'package:to_do/moor_db/database_helpers.dart';

class ToDoState {
  final List<DBTask> task;
  final bool isLoading;
  final bool isFailed;

  ToDoState(
      {required this.task, this.isLoading = false, this.isFailed = false});
}
