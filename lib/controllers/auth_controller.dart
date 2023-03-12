import 'package:flutter/animation.dart';
import 'package:flutter_test_app/utils/errors.dart';
import 'package:get/get.dart';
import 'package:flutter_test_app/api/auth_repository.dart';
import 'package:flutter_test_app/api/user_repository.dart';
import 'package:flutter_test_app/models/user.dart';
import 'package:flutter_test_app/utils/storage.dart';

class AuthController extends GetxController {
  final _user = Rx<User?>(null);
  User? get user => _user.value;

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  Future<bool> checkLoggedInSession({
    VoidCallback? onError,
    VoidCallback? onSuccess,
  }) async {
    _user.value = null;
    final userId = await loadUserId();
    bool validToken = userId != null && userId.isNotEmpty;

    if (validToken) {
      final userInfoResponse = await UserRepository.fetchUser();

      if (userInfoResponse.success) {
        _user.value = userInfoResponse.data!;
        onSuccess?.call();
        _isLoading.value = false;

        return true;
      }
    }

    onError?.call();

    return false;
  }

  Future<bool> login({
    required String email,
    required String password,
    VoidCallback? onError,
    VoidCallback? onInvalidCredentials,
    VoidCallback? onSuccess,
  }) async {
    _isLoading.value = true;
    _user.value = null;

    final response = await AuthRepository.login(
      email: email,
      password: password,
    );

    if (response.success) {
      final userInfoResponse = await UserRepository.fetchUser();

      if (userInfoResponse.success) {
        await storeUserId(response.data!);

        _user.value = userInfoResponse.data!;
        onSuccess?.call();
        _isLoading.value = false;

        return true;
      }
    } else if (response.errorCode == Errors.invalidCredentials) {
      onInvalidCredentials?.call();
      _isLoading.value = false;

      return false;
    }

    onError?.call();
    _isLoading.value = false;

    return false;
  }

  Future<bool> register({
    required String email,
    required String password,
    VoidCallback? onError,
    VoidCallback? onInvalidCredentials,
    VoidCallback? onSuccess,
  }) async {
    _isLoading.value = true;
    _user.value = null;

    final response = await AuthRepository.register(
      email: email,
      password: password,
    );

    if (response.success) {
      final userInfoResponse = await UserRepository.fetchUser();

      if (userInfoResponse.success) {
        await storeUserId(response.data!);

        _user.value = userInfoResponse.data!;
        onSuccess?.call();
        _isLoading.value = false;

        return true;
      }
    } else if (response.errorCode == Errors.invalidCredentials) {
      onInvalidCredentials?.call();
      _isLoading.value = false;

      return false;
    }

    onError?.call();
    _isLoading.value = false;

    return false;
  }

  Future<void> logout({VoidCallback? onLogOut}) async {
    await eraseUserId();
    _user.value = null;
    onLogOut?.call();
  }
}
