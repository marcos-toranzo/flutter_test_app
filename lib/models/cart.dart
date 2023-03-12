import 'package:flutter_test_app/models/model.dart';
import 'package:flutter_test_app/utils/iterable_utils.dart';
import 'package:flutter_test_app/utils/types.dart';

class CartEntry {
  final Id bookId;
  final int count;

  const CartEntry({required this.bookId, this.count = 1});
}

class Cart extends Model {
  final List<CartEntry> entries;

  const Cart({
    required super.id,
    this.entries = const [],
  });

  int get total =>
      entries.reduceAndCompute((acc, entry) => acc + entry.count, 0);
}
