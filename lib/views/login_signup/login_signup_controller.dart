import 'package:flutter/material.dart';
import 'package:flutter_test_app/controllers/auth_controller.dart';
import 'package:get/get.dart';

class LoginSignUpController extends GetxController {
  final AuthController _authController;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();

  LoginSignUpController(this._authController);

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    repeatPasswordController.dispose();
    super.onClose();
  }

  final _isLogingIn = true.obs;
  bool get isLogingIn => _isLogingIn.value;

  final _isLoading = false.obs;
  bool get isLoading => _authController.isLoading || _isLoading.value;

  void onSubmit({
    VoidCallback? onError,
    VoidCallback? onSuccess,
    VoidCallback? onInvalidCredentials,
  }) async {
    _isLoading.value = true;

    late final Future<bool> Function({
      required String email,
      required String password,
      VoidCallback? onError,
      VoidCallback? onInvalidCredentials,
      VoidCallback? onSuccess,
    }) function;

    if (isLogingIn) {
      function = _authController.login;
    } else {
      function = _authController.register;
    }

    await function(
      email: emailController.text,
      password: passwordController.text,
      onError: onError,
      onSuccess: onSuccess,
      onInvalidCredentials: onInvalidCredentials,
    );

    _isLoading.value = false;
  }

  void changeMode() {
    repeatPasswordController.clear();
    _isLogingIn.value = !isLogingIn;
  }
}
