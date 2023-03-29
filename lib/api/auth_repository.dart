import 'package:flutter_test_app/api/user_repository.dart';
import 'package:flutter_test_app/app_configuration.dart';
import 'package:flutter_test_app/models/cart.dart';
import 'package:flutter_test_app/models/model.dart';
import 'package:flutter_test_app/models/password.dart';
import 'package:flutter_test_app/models/user.dart';
import 'package:flutter_test_app/services/database_service/database_service.dart';
import 'package:flutter_test_app/services/network_service/network_service.dart';
import 'package:flutter_test_app/utils/errors.dart';

abstract class AuthRepository {
  static Future<ApiResponse<User>> login({
    required String email,
    required String password,
  }) async {
    try {
      final userResponse = await UserRepository.fetchUser(email: email);

      if (!userResponse.success) {
        return const ErrorApiResponse(errorCode: Error.invalidCredentials);
      }

      final passwordQuery = await databaseService.get(
        tableName: Password.tableName,
        whereClauses: [
          WhereEqualClause(
            column: Password.columnUserId,
            value: userResponse.data!.id,
          ),
          WhereEqualClause(
            column: Password.columnValue,
            value: password,
          ),
        ],
      );

      if (passwordQuery.isEmpty) {
        return const ErrorApiResponse(errorCode: Error.invalidCredentials);
      }

      return SuccessApiResponse(data: userResponse.data!);
    } catch (e) {
      return ErrorApiResponse(errorMessage: e.toString());
    }
  }

  static Future<ApiResponse<User>> register({
    required String email,
    required String password,
  }) async {
    try {
      final userResponse = await UserRepository.fetchUser(email: email);

      if (userResponse.success) {
        return const ErrorApiResponse(errorCode: Error.emailAlreadyInUse);
      }

      final cartId = await databaseService.insert(
        tableName: Cart.tableName,
        model: Cart(),
      );

      if (cartId == 0) {
        return const ErrorApiResponse(errorCode: Error.unknown);
      }

      final userId = await databaseService.insert(
        tableName: User.tableName,
        model: User(email: email, cartId: cartId),
      );

      if (userId == 0) {
        await databaseService.delete(
          tableName: Cart.tableName,
          whereClauses: [
            WhereEqualClause(column: Model.columnId, value: cartId),
          ],
        );

        return const ErrorApiResponse(errorCode: Error.unknown);
      }

      final passwordId = await databaseService.insert(
        tableName: Password.tableName,
        model: Password(value: password, userId: userId),
      );

      if (passwordId == 0) {
        await databaseService.delete(
          tableName: Cart.tableName,
          whereClauses: [
            WhereEqualClause(column: Model.columnId, value: cartId),
          ],
        );
        await databaseService.delete(
          tableName: User.tableName,
          whereClauses: [
            WhereEqualClause(column: Model.columnId, value: userId),
          ],
        );

        return const ErrorApiResponse(errorCode: Error.unknown);
      }

      return SuccessApiResponse(
        data: User(
          id: userId,
          email: email,
          cartId: cartId,
        ),
      );
    } catch (e) {
      return ErrorApiResponse(errorMessage: e.toString());
    }
  }
}
