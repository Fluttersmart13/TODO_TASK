import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:to_do/moor_db/table/db_task.dart';

part 'database_helpers.g.dart';

@UseMoor(
  tables: [DBTasks],
  daos: [TasksDao],
)
class AppDatabase extends _$AppDatabase {
  static final sharedInstance = AppDatabase();

  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: "db.sqlite", logStatements: false));

  @override
  int get schemaVersion => 1;
}

@UseDao(tables: [DBTasks])
class TasksDao extends DatabaseAccessor<AppDatabase> with _$TasksDaoMixin {
  final AppDatabase db;
  TasksDao(this.db) : super(db);

  addTask(DBTask task) =>
      into(db.dBTasks).insert(task, mode: InsertMode.replace);

  Future<List<DBTask>> getTaskByType(String type) =>
      (select(db.dBTasks)..where((task) => task.type.equals(type))).get();

  Future<List<DBTask>> getAllTask() => select(db.dBTasks).get();

  updateTask(DBTask task) => update(db.dBTasks).replace(task);
}
