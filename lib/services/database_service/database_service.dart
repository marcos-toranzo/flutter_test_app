import 'package:flutter_test_app/models/model.dart';
import 'package:flutter_test_app/utils/types.dart';

abstract class WhereClause<T> {
  final String column;
  final T value;

  const WhereClause({required this.column, required this.value});
}

class WhereEqualClause extends WhereClause<Object> {
  const WhereEqualClause({required super.column, required super.value});
}

class WhereInClause extends WhereClause<List<Object>> {
  const WhereInClause({required super.column, required super.value});
}

abstract class DatabaseService {
  Future<void> open(String name);

  Future<Id> insert({
    required String tableName,
    required Model model,
  });

  Future<List<Map<String, dynamic>>> get({
    required String tableName,
    List<String>? columns,
    List<WhereClause>? whereClauses,
  });

  Future<int> update({
    required String tableName,
    required Model model,
    List<WhereClause>? whereClauses,
  });

  Future<int> delete({
    required String tableName,
    List<WhereClause>? whereClauses,
  });
}
