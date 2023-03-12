import 'package:flutter_test_app/models/cart.dart';
import 'package:flutter_test_app/services/network_service/network_service.dart';
import 'package:flutter_test_app/utils/types.dart';

//! DELETE: fetch cart correctly from service
const cart = Cart(id: 'cart1');

class CartRepository {
  static Future<ApiResponse<Cart>> fetchCart(Id id) async {
    return Future.delayed(
      const Duration(seconds: 1),
      () => const ApiResponse(
        success: true,
        data: cart,
      ),
    );
  }
}
