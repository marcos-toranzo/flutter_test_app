import 'package:flutter_test_app/models/cart.dart';
import 'package:flutter_test_app/models/cart_entry.dart';
import 'package:flutter_test_app/models/model.dart';
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
    required Id whereId,
  }) async {
    if (_database == null) {
      throw Exception('Database has not been opened.'
          '`DatabaseService.open()` was not called');
    }

    return await _database!.update(
      tableName,
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
      where: '${Model.columnId} = ?',
      whereArgs: [whereId],
    );
  }

  @override
  Future<int> delete({
    required String tableName,
    required Id whereId,
  }) async {
    if (_database == null) {
      throw Exception('Database has not been opened.'
          '`DatabaseService.open()` was not called');
    }

    return await _database!.delete(
      tableName,
      where: '${Model.columnId} = ?',
      whereArgs: [whereId],
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
              FOREIGN KEY (${User.columnCartId}) REFERENCES ${Cart.tableName} (${Model.columnId}) ON DELETE RESTRICT
              )
            ''');
        await db.execute('''
            CREATE TABLE ${Cart.tableName}(
              ${Model.columnId} integer PRIMARY KEY AUTOINCREMENT
              )
            ''');
        await db.execute('''
            CREATE TABLE ${CartEntry.tableName}(
              ${Model.columnId} integer PRIMARY KEY AUTOINCREMENT,
              ${CartEntry.columnCount} integer NOT NULL,
              ${CartEntry.columnBookId} text NOT NULL,
              FOREIGN KEY (${CartEntry.columnCartId}) REFERENCES ${Cart.tableName} (${Model.columnId}) ON DELETE CASCADE
              )
            ''');
      },
      onConfigure: (Database db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
    );
  }
}
