import 'package:flutter_test_app/models/model.dart';
import 'package:flutter_test_app/utils/types.dart';

abstract class DatabaseService {
  Future<void> open(String name);
  Future<Id> insert({required String tableName, required Model model});
  Future<int> update({
    required String tableName,
    required Model model,
    required Id whereId,
  });
  Future<int> delete({required String tableName, required Id whereId});
}
