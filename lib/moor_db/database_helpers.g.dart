// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_helpers.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class DBTask extends DataClass implements Insertable<DBTask> {
  final String Title;
  final String Description;
  final String type;
  final String id;
  DBTask(
      {required this.Title,
      required this.Description,
      required this.type,
      required this.id});
  factory DBTask.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return DBTask(
      Title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      Description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description'])!,
      type: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}type'])!,
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['title'] = Variable<String>(Title);
    map['description'] = Variable<String>(Description);
    map['type'] = Variable<String>(type);
    map['id'] = Variable<String>(id);
    return map;
  }

  DBTasksCompanion toCompanion(bool nullToAbsent) {
    return DBTasksCompanion(
      Title: Value(Title),
      Description: Value(Description),
      type: Value(type),
      id: Value(id),
    );
  }

  factory DBTask.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return DBTask(
      Title: serializer.fromJson<String>(json['Title']),
      Description: serializer.fromJson<String>(json['Description']),
      type: serializer.fromJson<String>(json['type']),
      id: serializer.fromJson<String>(json['id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'Title': serializer.toJson<String>(Title),
      'Description': serializer.toJson<String>(Description),
      'type': serializer.toJson<String>(type),
      'id': serializer.toJson<String>(id),
    };
  }

  DBTask copyWith(
          {String? Title, String? Description, String? type, String? id}) =>
      DBTask(
        Title: Title ?? this.Title,
        Description: Description ?? this.Description,
        type: type ?? this.type,
        id: id ?? this.id,
      );
  @override
  String toString() {
    return (StringBuffer('DBTask(')
          ..write('Title: $Title, ')
          ..write('Description: $Description, ')
          ..write('type: $type, ')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(Title, Description, type, id);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DBTask &&
          other.Title == this.Title &&
          other.Description == this.Description &&
          other.type == this.type &&
          other.id == this.id);
}

class DBTasksCompanion extends UpdateCompanion<DBTask> {
  final Value<String> Title;
  final Value<String> Description;
  final Value<String> type;
  final Value<String> id;
  const DBTasksCompanion({
    this.Title = const Value.absent(),
    this.Description = const Value.absent(),
    this.type = const Value.absent(),
    this.id = const Value.absent(),
  });
  DBTasksCompanion.insert({
    required String Title,
    required String Description,
    required String type,
    required String id,
  })  : Title = Value(Title),
        Description = Value(Description),
        type = Value(type),
        id = Value(id);
  static Insertable<DBTask> custom({
    Expression<String>? Title,
    Expression<String>? Description,
    Expression<String>? type,
    Expression<String>? id,
  }) {
    return RawValuesInsertable({
      if (Title != null) 'title': Title,
      if (Description != null) 'description': Description,
      if (type != null) 'type': type,
      if (id != null) 'id': id,
    });
  }

  DBTasksCompanion copyWith(
      {Value<String>? Title,
      Value<String>? Description,
      Value<String>? type,
      Value<String>? id}) {
    return DBTasksCompanion(
      Title: Title ?? this.Title,
      Description: Description ?? this.Description,
      type: type ?? this.type,
      id: id ?? this.id,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (Title.present) {
      map['title'] = Variable<String>(Title.value);
    }
    if (Description.present) {
      map['description'] = Variable<String>(Description.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DBTasksCompanion(')
          ..write('Title: $Title, ')
          ..write('Description: $Description, ')
          ..write('type: $type, ')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }
}

class $DBTasksTable extends DBTasks with TableInfo<$DBTasksTable, DBTask> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DBTasksTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _TitleMeta = const VerificationMeta('Title');
  @override
  late final GeneratedColumn<String?> Title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _DescriptionMeta =
      const VerificationMeta('Description');
  @override
  late final GeneratedColumn<String?> Description = GeneratedColumn<String?>(
      'description', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String?> type = GeneratedColumn<String?>(
      'type', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [Title, Description, type, id];
  @override
  String get aliasedName => _alias ?? 'd_b_tasks';
  @override
  String get actualTableName => 'd_b_tasks';
  @override
  VerificationContext validateIntegrity(Insertable<DBTask> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('title')) {
      context.handle(
          _TitleMeta, Title.isAcceptableOrUnknown(data['title']!, _TitleMeta));
    } else if (isInserting) {
      context.missing(_TitleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _DescriptionMeta,
          Description.isAcceptableOrUnknown(
              data['description']!, _DescriptionMeta));
    } else if (isInserting) {
      context.missing(_DescriptionMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DBTask map(Map<String, dynamic> data, {String? tablePrefix}) {
    return DBTask.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $DBTasksTable createAlias(String alias) {
    return $DBTasksTable(attachedDatabase, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $DBTasksTable dBTasks = $DBTasksTable(this);
  late final TasksDao tasksDao = TasksDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [dBTasks];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$TasksDaoMixin on DatabaseAccessor<AppDatabase> {
  $DBTasksTable get dBTasks => attachedDatabase.dBTasks;
}
