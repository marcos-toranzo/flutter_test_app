import 'package:flutter_test_app/models/cart.dart';
import 'package:flutter_test_app/models/cart_entry.dart';
import 'package:flutter_test_app/models/model.dart';
import 'package:flutter_test_app/models/password.dart';
import 'package:flutter_test_app/models/user.dart';
import 'package:flutter_test_app/services/database_service/database_service.dart';
import 'package:flutter_test_app/utils/types.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqfliteDatabaseService extends DatabaseService {
  Database? _database;

  @override
  Future<Id> insert({
    required String tableName,
    required Model model,
  }) async {
    if (_database == null) {
      throw Exception('Database has not been opened.'
          '`DatabaseService.open()` was not called');
    }

    return await _database!.insert(
      tableName,
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<int> update({
    required String tableName,
    required Model model,
    List<WhereClause>? whereClauses,
  }) async {
    if (_database == null) {
      throw Exception('Database has not been opened.'
          '`DatabaseService.open()` was not called');
    }

    final whereClausesParsed = _parseWhereClauses(whereClauses);

    if (whereClauses != null) {
      for (var whereClause in whereClauses) {
        if (whereClause is WhereInClause) {}
      }
    }

    return await _database!.update(
      tableName,
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
      where: whereClausesParsed.where,
      whereArgs: whereClausesParsed.whereArgs,
    );
  }

  @override
  Future<int> delete({
    required String tableName,
    List<WhereClause>? whereClauses,
  }) async {
    if (_database == null) {
      throw Exception('Database has not been opened.'
          '`DatabaseService.open()` was not called');
    }

    final whereClausesParsed = _parseWhereClauses(whereClauses);

    return await _database!.delete(
      tableName,
      where: whereClausesParsed.where,
      whereArgs: whereClausesParsed.whereArgs,
    );
  }

  @override
  Future<void> open(String name) async {
    _database = await openDatabase(
      join(await getDatabasesPath(), name),
      onCreate: (db, version) async {
        await db.execute('''
            CREATE TABLE ${User.tableName}(
              ${Model.columnId} integer PRIMARY KEY AUTOINCREMENT,
              ${User.columnEmail} text NOT NULL,
              ${User.columnCartId} integer NOT NULL,
              FOREIGN KEY (${User.columnCartId}) REFERENCES ${Cart.tableName} (${Model.columnId}) ON DELETE RESTRICT
              )
            ''');
        await db.execute('''
            CREATE TABLE ${Password.tableName}(
              ${Model.columnId} integer PRIMARY KEY AUTOINCREMENT,
              ${Password.columnValue} text NOT NULL,
              ${Password.columnUserId} integer NOT NULL,
              FOREIGN KEY (${Password.columnUserId}) REFERENCES ${User.tableName} (${Model.columnId}) ON DELETE CASCADE
              )
            ''');
        await db.execute('''
            CREATE TABLE ${Cart.tableName}(
              ${Model.columnId} integer PRIMARY KEY AUTOINCREMENT,
              ${Cart.columnTotalCount} integer NOT NULL
              )
            ''');
        await db.execute('''
            CREATE TABLE ${CartEntry.tableName}(
              ${Model.columnId} integer PRIMARY KEY AUTOINCREMENT,
              ${CartEntry.columnCount} integer NOT NULL,
              ${CartEntry.columnBookId} text NOT NULL,
              ${CartEntry.columnCartId} integer NOT NULL,
              FOREIGN KEY (${CartEntry.columnCartId}) REFERENCES ${Cart.tableName} (${Model.columnId}) ON DELETE CASCADE
              )
            ''');
      },
      onConfigure: (Database db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      version: 1,
    );
  }

  @override
  Future<List<Map<String, dynamic>>> get({
    required String tableName,
    List<String>? columns,
    List<WhereClause>? whereClauses,
  }) async {
    if (_database == null) {
      throw Exception('Database has not been opened.'
          '`DatabaseService.open()` was not called');
    }

    final whereClausesParsed = _parseWhereClauses(whereClauses);

    final result = await _database!.query(
      tableName,
      columns: columns,
      where: whereClausesParsed.where,
      whereArgs: whereClausesParsed.whereArgs,
    );

    return result;
  }
}

class _WhereClauseParsingResult {
  final String? where;
  final List<Object?>? whereArgs;

  const _WhereClauseParsingResult({
    this.where,
    this.whereArgs,
  });
}

_WhereClauseParsingResult _parseWhereClauses(List<WhereClause>? whereClauses) {
  if (whereClauses == null) {
    return const _WhereClauseParsingResult();
  }

  final List<Object?> whereArgs = [];

  final List<String> wheres = [];

  for (var whereClause in whereClauses) {
    switch (whereClause.runtimeType) {
      case WhereEqualClause:
        wheres.add('${whereClause.column} = ?');
        break;
      case WhereInClause:
        final whereInClause = whereClause as WhereInClause;

        wheres.add(
          '${whereClause.column} IN'
          '(${List.filled(whereInClause.value.length, '?').join(', ')})',
        );
        break;
    }

    whereArgs.add(whereClause.value);
  }

  return _WhereClauseParsingResult(
    where: wheres.join(' AND '),
    whereArgs: whereArgs,
  );
}
