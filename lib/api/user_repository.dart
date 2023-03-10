import 'dart:convert';

import 'package:flutter_test_app/app_configuration.dart';
import 'package:flutter_test_app/models/user.dart';
import 'package:flutter_test_app/services/network_service/network_service.dart';

final userEndpoint = '${Environment.apiBaseUrl}/${Environment.userEndpoint}';

class UserRepository {
  static Future<ApiResponse<User>> fetchUser() async {
    try {
      final response = await networkService.get(userEndpoint);
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data = body['data'];

        return ApiResponse(
          success: true,
          data: User(
            id: data['id'],
            email: data['email'],
          ),
        );
      } else {
        return ApiResponse(
          success: false,
          errorMessage: body['errors'],
        );
      }
    } catch (e) {
      return ApiResponse(
        success: false,
        errorMessage: e.toString(),
      );
    }
  }
}
