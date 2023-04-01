import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_app/api/auth_repository.dart';
import 'package:flutter_test_app/app_configuration.dart';
import 'package:flutter_test_app/models/cart.dart';
import 'package:flutter_test_app/models/model.dart';
import 'package:flutter_test_app/models/password.dart';
import 'package:flutter_test_app/models/user.dart';
import 'package:flutter_test_app/utils/errors.dart';

import '../../test_utils/mocks/advanced_mock_database_service.dart';

void main() {
  test('AuthRepository should not login invalid email', () async {
    databaseService = AdvancedMockDatabaseService();

    final response = await AuthRepository.login(
      email: 'email@email.com',
      password: 'a',
    );

    expect(response.success, false);
    expect(response.errorCode, Error.invalidCredentials);
  });

  test('AuthRepository should not login invalid password', () async {
    databaseService = AdvancedMockDatabaseService();

    final cartId = await databaseService.insert(
      tableName: Cart.tableName,
      model: Cart(),
    );

    final userId = await databaseService.insert(
      tableName: User.tableName,
      model: User(email: 'user@email.com', cartId: cartId),
    );

    await databaseService.insert(
      tableName: Password.tableName,
      model: Password(value: 'a', userId: userId),
    );

    final response = await AuthRepository.login(
      email: 'user@email.com',
      password: 'ab',
    );

    expect(response.success, false);
    expect(response.errorCode, Error.invalidCredentials);
  });

  test('AuthRepository should not login invalid password', () async {
    databaseService = AdvancedMockDatabaseService();

    final cartId = await databaseService.insert(
      tableName: Cart.tableName,
      model: Cart(),
    );

    final userId = await databaseService.insert(
      tableName: User.tableName,
      model: User(email: 'user@email.com', cartId: cartId),
    );

    await databaseService.insert(
      tableName: Password.tableName,
      model: Password(value: 'a', userId: userId),
    );

    final response = await AuthRepository.login(
      email: 'user@email.com',
      password: 'ab',
    );

    expect(response.success, false);
    expect(response.errorCode, Error.invalidCredentials);
  });

  test('AuthRepository should login', () async {
    databaseService = AdvancedMockDatabaseService();

    const userEmail = 'user@email.com';
    const password = 'a';

    final cartId = await databaseService.insert(
      tableName: Cart.tableName,
      model: Cart(),
    );

    final userId = await databaseService.insert(
      tableName: User.tableName,
      model: User(email: userEmail, cartId: cartId),
    );

    await databaseService.insert(
      tableName: Password.tableName,
      model: Password(value: password, userId: userId),
    );

    final response = await AuthRepository.login(
      email: userEmail,
      password: password,
    );

    expect(response.success, true);
    expect(response.data, isNotNull);

    final responseData = response.data!;

    expect(responseData.id, userId);
    expect(responseData.email, userEmail);
    expect(responseData.cartId, cartId);
  });

  test('AuthRepository should register user', () async {
    databaseService = AdvancedMockDatabaseService();

    const userEmail = 'user@email.com';
    const userPassword = 'a';

    final response = await AuthRepository.register(
      email: userEmail,
      password: userPassword,
    );

    expect(response.success, true);
    expect(response.data, isNotNull);

    final responseData = response.data!;

    final userQuery = await databaseService.get(tableName: User.tableName);

    expect(userQuery.length, 1);

    final user = User.fromMap(userQuery[0]);

    final cartQuery = await databaseService.get(tableName: Cart.tableName);

    expect(cartQuery.length, 1);

    final cart = Cart(id: cartQuery[0][Model.columnId]);

    final passwordQuery =
        await databaseService.get(tableName: Password.tableName);

    expect(passwordQuery.length, 1);

    final password = Password(
      value: passwordQuery[0][Password.columnValue],
      userId: passwordQuery[0][Password.columnUserId],
    );

    expect(responseData.cartId, cart.id);
    expect(responseData.email, userEmail);
    expect(responseData.id, user.id);
    expect(password.value, userPassword);
    expect(password.userId, user.id);
  });

  test('AuthRepository should not register used email', () async {
    databaseService = AdvancedMockDatabaseService();

    const userEmail = 'user@email.com';
    const password = 'a';

    final cartId = await databaseService.insert(
      tableName: Cart.tableName,
      model: Cart(),
    );

    final userId = await databaseService.insert(
      tableName: User.tableName,
      model: User(email: userEmail, cartId: cartId),
    );

    await databaseService.insert(
      tableName: Password.tableName,
      model: Password(value: password, userId: userId),
    );

    final response = await AuthRepository.register(
      email: userEmail,
      password: password,
    );

    expect(response.success, false);
    expect(response.errorCode, Error.emailAlreadyInUse);
  });
}
