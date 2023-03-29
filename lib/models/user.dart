import 'package:flutter_test_app/models/model.dart';
import 'package:flutter_test_app/utils/types.dart';

class User extends Model {
  static const String tableName = 'users';
  static const String columnEmail = 'email';
  static const String columnCartId = 'cartId';

  late final String email;
  late final Id cartId;

  User({
    super.id,
    required this.email,
    required this.cartId,
  });

  User.fromMap(Map<String, dynamic> map) : super.fromMap(map) {
    email = map[columnEmail] as String;
    cartId = map[columnCartId] as Id;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      columnEmail: email,
      columnCartId: cartId,
    };
  }
}
