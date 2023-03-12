import 'package:flutter_test_app/models/cart.dart';
import 'package:flutter_test_app/models/model.dart';

class User extends Model {
  final String email;
  final String username;
  final Cart cart;

  const User({
    required super.id,
    required this.email,
    required this.username,
    required this.cart,
  });
}
