import 'package:flutter_test_app/models/model.dart';
import 'package:flutter_test_app/utils/types.dart';

class User extends Model {
  static const String tableName = 'users';
  static const String columnEmail = 'email';
  static const String columnCartId = 'cartId';

  final String email;
  final Id cartId;

  const User({
    required super.id,
    required this.email,
    required this.cartId,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      columnEmail: email,
      columnCartId: cartId,
    };
  }
}
