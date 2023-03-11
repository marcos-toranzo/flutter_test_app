import 'package:flutter_test_app/models/cart.dart';
import 'package:flutter_test_app/models/user.dart';
import 'package:flutter_test_app/services/network_service/network_service.dart';

//! DELETE: fetch user correctly from service
const cart = Cart(id: '2_1');
const user = User(
  id: '1_1',
  email: 'user@email.com',
  cart: cart,
  username: 'User',
);

class UserRepository {
  static Future<ApiResponse<User>> fetchUser() async {
    return Future.delayed(
      const Duration(seconds: 1),
      () => const ApiResponse(
        success: true,
        data: user,
      ),
    );
  }
}
