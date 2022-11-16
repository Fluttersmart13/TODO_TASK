import 'package:moor_flutter/moor_flutter.dart';

class DBTasks extends Table {
  TextColumn get Title => text()();
  TextColumn get Description => text()();
  TextColumn get type => text()();
  TextColumn get id => text()();
  Set<Column> get primaryKey => {id};
}
