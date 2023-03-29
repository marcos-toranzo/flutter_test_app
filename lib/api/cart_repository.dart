import 'package:flutter_test_app/app_configuration.dart';
import 'package:flutter_test_app/models/cart.dart';
import 'package:flutter_test_app/models/cart_entry.dart';
import 'package:flutter_test_app/models/model.dart';
import 'package:flutter_test_app/services/database_service/database_service.dart';
import 'package:flutter_test_app/services/network_service/network_service.dart';
import 'package:flutter_test_app/utils/errors.dart';
import 'package:flutter_test_app/utils/iterable_utils.dart';
import 'package:flutter_test_app/utils/types.dart';

abstract class CartRepository {
  static Future<ApiResponse<Cart>> fetchCart(Id id) async {
    try {
      final cartQuery = await databaseService.get(
        tableName: Cart.tableName,
        whereClauses: [
          WhereEqualClause(column: Model.columnId, value: id),
        ],
      );

      if (cartQuery.isEmpty) {
        return const ErrorApiResponse(errorCode: Error.modelNotFound);
      }

      final cartEntriesQuery = await databaseService.get(
        tableName: CartEntry.tableName,
        whereClauses: [
          WhereEqualClause(column: CartEntry.columnCartId, value: id),
        ],
      );

      final cartEntries = cartEntriesQuery.mapList(
        (cartEntry) => CartEntry.fromMap(cartEntry),
      );

      return SuccessApiResponse(data: Cart(id: id, entries: cartEntries));
    } catch (e) {
      return ErrorApiResponse(errorMessage: e.toString());
    }
  }

  static Future<ApiResponse<CartEntry>> addBook({
    required Id cartId,
    required String bookId,
  }) async {
    final entryQuery = await databaseService.get(
      tableName: CartEntry.tableName,
      whereClauses: [
        WhereEqualClause(column: CartEntry.columnCartId, value: cartId),
        WhereEqualClause(column: CartEntry.columnBookId, value: bookId),
      ],
    );

    final entry =
        entryQuery.isEmpty ? null : CartEntry.fromMap(entryQuery.first);

    if (entry != null) {
      final updateCount = await databaseService.update(
        tableName: CartEntry.tableName,
        model: entry.copyWithCount(entry.count + 1),
        whereClauses: [
          WhereEqualClause(column: Model.columnId, value: entry.id),
        ],
      );

      if (updateCount != 1) {
        return const ErrorApiResponse(errorCode: Error.unknown);
      }

      return const SuccessApiResponse();
    }

    final id = await databaseService.insert(
      tableName: CartEntry.tableName,
      model: CartEntry(bookId: bookId, cartId: cartId),
    );

    if (id == 0) {
      return const ErrorApiResponse(errorCode: Error.unknown);
    }

    return SuccessApiResponse(
      data: CartEntry(id: id, bookId: bookId, cartId: cartId),
    );
  }

  static Future<ApiResponse<CartEntry>> removeBook({
    required Id cartId,
    required String bookId,
    int count = 1,
  }) async {
    final entryQuery = await databaseService.get(
      tableName: CartEntry.tableName,
      whereClauses: [
        WhereEqualClause(column: CartEntry.columnCartId, value: cartId),
        WhereEqualClause(column: CartEntry.columnBookId, value: bookId),
      ],
    );

    if (entryQuery.length != 1) {
      return const ErrorApiResponse(errorCode: Error.modelNotFound);
    }

    final entry = CartEntry.fromMap(entryQuery.first);

    if (entry.count <= count) {
      final deleteCount = await databaseService.delete(
        tableName: CartEntry.tableName,
        whereClauses: [
          WhereEqualClause(column: Model.columnId, value: entry.id),
        ],
      );

      if (deleteCount != 1) {
        return const ErrorApiResponse(errorCode: Error.unknown);
      }

      return const SuccessApiResponse();
    }

    final updateCount = await databaseService.update(
      tableName: CartEntry.tableName,
      model: entry.copyWithCount(entry.count - count),
      whereClauses: [
        WhereEqualClause(column: Model.columnId, value: entry.id),
      ],
    );

    if (updateCount != 1) {
      return const ErrorApiResponse(errorCode: Error.unknown);
    }

    return SuccessApiResponse(data: entry);
  }

  static Future<ApiResponse<Never>> empty(Id cartId) async {
    await databaseService.delete(
      tableName: CartEntry.tableName,
      whereClauses: [
        WhereEqualClause(column: CartEntry.columnCartId, value: cartId),
      ],
    );

    return const SuccessApiResponse();
  }
}
