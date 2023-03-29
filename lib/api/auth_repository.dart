import 'package:flutter_test_app/api/user_repository.dart';
import 'package:flutter_test_app/services/network_service/network_service.dart';
import 'package:flutter_test_app/utils/errors.dart';
import 'package:flutter_test_app/utils/types.dart';

abstract class AuthRepository {
  static Future<ApiResponse<Id>> login({
    required String email,
    required String password,
  }) async {
    //! DELETE: use actual login method
    return Future.delayed(
      const Duration(seconds: 1),
      () {
        if (email == user.email) {
          return SuccessApiResponse(data: user.id);
        }
        return const ErrorApiResponse(errorCode: Error.invalidCredentials);
      },
    );
  }

  static Future<ApiResponse<Id>> register({
    required String email,
    required String password,
  }) async {
    //! DELETE: use actual login method
    return login(email: email, password: password);
  }
}
