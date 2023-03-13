import 'package:flutter_test_app/api/cart_repository.dart';
import 'package:flutter_test_app/models/user.dart';
import 'package:flutter_test_app/services/network_service/network_service.dart';

//! DELETE: fetch user correctly from service
final user = User(
  id: 'user1',
  email: 'user@email.com',
  cartId: cart.id,
  username: 'User',
);

class UserRepository {
  static Future<ApiResponse<User>> fetchUser() async {
    return Future.delayed(
      const Duration(seconds: 1),
      () => ApiResponse(
        success: true,
        data: user,
      ),
    );
  }
}
