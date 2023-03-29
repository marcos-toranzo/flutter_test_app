// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_test_app/models/model.dart';
import 'package:flutter_test_app/utils/types.dart';

class CartEntry extends Model {
  static const String tableName = 'cartEntries';
  static const String columnBookId = 'bookId';
  static const String columnCartId = 'cartId';
  static const String columnCount = 'count';

  late final String bookId;
  late final Id cartId;
  late final int count;

  CartEntry({
    super.id,
    required this.bookId,
    required this.cartId,
    this.count = 1,
  });

  CartEntry.fromMap(Map<String, dynamic> map) : super.fromMap(map) {
    bookId = map[columnBookId] as String;
    cartId = map[columnCartId] as Id;
    count = map[columnCount] as int;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      columnBookId: bookId,
      columnCartId: cartId,
      columnCount: count,
    };
  }

  CartEntry copyWithCount(int count) {
    return CartEntry(
      id: id,
      bookId: bookId,
      cartId: cartId,
      count: count,
    );
  }
}
