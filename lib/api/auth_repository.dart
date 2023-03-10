import 'package:flutter_test_app/app_configuration.dart';
import 'package:flutter_test_app/services/network_service/network_service.dart';

final loginEndpoint = '${Environment.apiBaseUrl}/${Environment.loginEndpoint}';
final registerEndpoint =
    '${Environment.apiBaseUrl}/${Environment.registerEndpoint}';

class AuthRepository {
  static Future<ApiResponse<Never>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await networkService.post(
        loginEndpoint,
        body: {
          'email': email,
          'password': password,
        },
      );

      return ApiResponse(success: response.statusCode == 200);
    } catch (e) {
      return ApiResponse(success: false, errorMessage: e.toString());
    }
  }

  static Future<ApiResponse<Never>> register({
    required String email,
    required String password,
  }) async {
    try {
      final response = await networkService.post(
        registerEndpoint,
        body: {
          'email': email,
          'password': password,
        },
      );

      return ApiResponse(success: response.statusCode == 200);
    } catch (e) {
      return ApiResponse(success: false, errorMessage: e.toString());
    }
  }
}
