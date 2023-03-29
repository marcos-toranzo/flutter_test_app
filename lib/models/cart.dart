import 'package:flutter_test_app/models/cart_entry.dart';
import 'package:flutter_test_app/models/model.dart';

class Cart extends Model {
  static const String tableName = 'carts';

  final List<CartEntry> entries;

  const Cart({
    required super.id,
    this.entries = const [],
  });
}
