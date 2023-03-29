import 'package:flutter_test_app/app_configuration.dart';
import 'package:flutter_test_app/models/model.dart';
import 'package:flutter_test_app/models/user.dart';
import 'package:flutter_test_app/services/database_service/database_service.dart';
import 'package:flutter_test_app/services/network_service/network_service.dart';
import 'package:flutter_test_app/utils/errors.dart';

abstract class UserRepository {
  static Future<ApiResponse<User>> fetchUser({
    String? email,
    String? id,
  }) async {
    try {
      final userResponse = await databaseService.get(
        tableName: User.tableName,
        whereClauses: [
          if (email != null)
            WhereEqualClause(
              column: User.columnEmail,
              value: email,
            ),
          if (id != null)
            WhereEqualClause(
              column: Model.columnId,
              value: id,
            ),
        ],
      );

      if (userResponse.isEmpty) {
        return const ErrorApiResponse(errorCode: Error.modelNotFound);
      }
      if (userResponse.length > 1) {
        return const ErrorApiResponse(errorCode: Error.moreThanOneModelFound);
      }

      return SuccessApiResponse(data: User.fromMap(userResponse.first));
    } catch (e) {
      return ErrorApiResponse(errorMessage: e.toString());
    }
  }
}
