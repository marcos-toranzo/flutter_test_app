import 'package:flutter_test_app/models/cart.dart';
import 'package:flutter_test_app/models/model.dart';
import 'package:flutter_test_app/models/password.dart';
import 'package:flutter_test_app/models/user.dart';
import 'package:flutter_test_app/services/database_service/database_service.dart';
import 'package:flutter_test_app/utils/types.dart';

import 'data.dart';

class MockDatabaseService extends DatabaseService {
  @override
  Future<Id> insert({
    required String tableName,
    required Model model,
  }) async {
    return 0;
  }

  @override
  Future<int> update({
    required String tableName,
    required Model model,
    List<WhereClause>? whereClauses,
  }) async {
    return 0;
  }

  @override
  Future<int> delete({
    required String tableName,
    List<WhereClause>? whereClauses,
  }) async {
    return 0;
  }

  @override
  Future<void> open(String name) async {}

  @override
  Future<List<Map<String, dynamic>>> get({
    required String tableName,
    List<String>? columns,
    List<WhereClause>? whereClauses,
  }) async {
    if (tableName == User.tableName) {
      return [mockUser.toMap()];
    }
    if (tableName == Cart.tableName) {
      return [mockCart.toMap()];
    }
    if (tableName == Password.tableName) {
      return [mockPassword.toMap()];
    }

    return [];
  }
}
