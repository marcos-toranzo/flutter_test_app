import 'package:flutter_test_app/models/cart.dart';
import 'package:flutter_test_app/models/cart_entry.dart';
import 'package:flutter_test_app/services/network_service/network_service.dart';
import 'package:flutter_test_app/utils/iterable_utils.dart';
import 'package:flutter_test_app/utils/types.dart';

//! DELETE: fetch cart correctly from service
var cart = const Cart(id: 2);

abstract class CartRepository {
  static Future<ApiResponse<Cart>> fetchCart(Id id) async {
    return Future.delayed(
      const Duration(seconds: 1),
      () => SuccessApiResponse(data: cart),
    );
  }

  static Future<ApiResponse<Cart>> addBook(String bookId) async {
    bool wasPresent = false;

    final newEntries = cart.entries.mapList(
      (entry) {
        if (entry.bookId == bookId) {
          wasPresent = true;

          return CartEntry(
            id: 1,
            cartId: cart.id,
            bookId: bookId,
            count: entry.count + 1,
          );
        } else {
          return entry;
        }
      },
    );

    if (!wasPresent) {
      newEntries.add(CartEntry(id: 1, cartId: cart.id, bookId: bookId));
    }

    final newCart = Cart(
      id: cart.id,
      entries: newEntries,
    );

    return Future.delayed(
      const Duration(seconds: 1),
      () {
        cart = newCart;

        return SuccessApiResponse(data: cart);
      },
    );
  }

  static Future<ApiResponse<Cart>> removeBook(
    String bookId, {
    int count = 1,
  }) async {
    final newEntries = cart.entries.mapWhereList(
      (entry) {
        if (entry.bookId == bookId) {
          return CartEntry(
            id: 1,
            cartId: cart.id,
            bookId: bookId,
            count: entry.count - count,
          );
        } else {
          return entry;
        }
      },
      (entry) => entry.count > 0,
    );

    final newCart = Cart(
      id: cart.id,
      entries: newEntries,
    );

    return Future.delayed(
      const Duration(seconds: 1),
      () {
        cart = newCart;

        return SuccessApiResponse(data: cart);
      },
    );
  }

  static Future<ApiResponse<Cart>> empty() async {
    final newCart = Cart(
      id: cart.id,
    );

    return Future.delayed(
      const Duration(seconds: 1),
      () {
        cart = newCart;

        return SuccessApiResponse(data: cart);
      },
    );
  }
}
