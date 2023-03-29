import 'package:flutter_test_app/models/model.dart';
import 'package:flutter_test_app/utils/types.dart';

class CartEntry extends Model {
  static const String tableName = 'cartEntries';
  static const String columnBookId = 'bookId';
  static const String columnCartId = 'cartId';
  static const String columnCount = 'count';

  final String bookId;
  final Id cartId;
  final int count;

  const CartEntry({
    required super.id,
    required this.bookId,
    required this.cartId,
    this.count = 1,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      columnBookId: bookId,
      columnCartId: cartId,
      columnCount: count,
    };
  }
}
