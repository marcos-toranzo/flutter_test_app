import 'package:flutter_test_app/models/model.dart';
import 'package:flutter_test_app/utils/types.dart';

class Password extends Model {
  static const String tableName = 'passwords';
  static const String columnValue = 'value';
  static const String columnUserId = 'userId';

  final String value;
  final Id userId;

  Password({
    super.id,
    required this.value,
    required this.userId,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      columnValue: value,
      columnUserId: userId,
    };
  }
}
