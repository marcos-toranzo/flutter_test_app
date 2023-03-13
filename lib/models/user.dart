import 'package:flutter_test_app/models/model.dart';
import 'package:flutter_test_app/utils/types.dart';

class User extends Model {
  final String email;
  final String username;
  final Id cartId;

  const User({
    required super.id,
    required this.email,
    required this.username,
    required this.cartId,
  });
}
