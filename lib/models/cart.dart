// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_test_app/models/cart_entry.dart';
import 'package:flutter_test_app/models/model.dart';
import 'package:flutter_test_app/utils/iterable_utils.dart';

class Cart extends Model {
  static const String tableName = 'carts';
  static const String columnTotalCount = 'totalCount';

  late final int totalCount;
  final List<CartEntry> entries;

  Cart({
    super.id,
    int? totalCount,
    this.entries = const [],
  }) {
    this.totalCount = totalCount ??
        entries.reduceAndCompute((acc, element) => acc + element.count, 0);
  }

  Cart copyWithEntries(List<CartEntry> entries) {
    return Cart(id: id, entries: entries);
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      columnTotalCount: totalCount,
    };
  }
}
