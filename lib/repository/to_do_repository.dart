import 'package:to_do/moor_db/database_helpers.dart';

class Repository {
  final _databaseInstance = AppDatabase.sharedInstance;
  List<DBTask> todaytasks = [];
  List<DBTask> tomorrowtasks = [];
  List<DBTask> upcomingtasks = [];
  List<DBTask> allTask = [];
  Future<List<DBTask>> getData(String type) async {
    if (type == "today") {
      try {
        final _tasks = await TasksDao(_databaseInstance).getTaskByType(type);
        if (_tasks != null) {
          todaytasks.addAll(_tasks);
        }
      } catch (ex) {
        todaytasks = [];
      }
      return todaytasks;
    } else if (type == "tomorrow") {
      try {
        final _tasks = await TasksDao(_databaseInstance).getTaskByType(type);
        if (_tasks != null) {
          tomorrowtasks.addAll(_tasks);
        }
      } catch (ex) {
        tomorrowtasks = [];
      }
      return tomorrowtasks;
    } else if (type == "upcoming") {
      try {
        final _tasks = await TasksDao(_databaseInstance).getTaskByType(type);
        if (_tasks != null) {
          upcomingtasks.addAll(_tasks);
        }
      } catch (ex) {
        upcomingtasks = [];
      }
      return upcomingtasks;
    } else {
      try {
        final _tasks = await TasksDao(_databaseInstance).getAllTask();
        if (_tasks != null) {
          allTask.addAll(_tasks);
        }
      } catch (ex) {
        allTask = [];
      }
      return allTask;
    }
  }
}
