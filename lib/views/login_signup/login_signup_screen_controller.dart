import 'package:flutter/material.dart';
import 'package:flutter_test_app/controllers/auth_controller.dart';
import 'package:get/get.dart';

class LoginSignUpScreenController extends GetxController {
  final AuthController authController;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();

  LoginSignUpScreenController({required this.authController});

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
  bool get isLoading => authController.isLoading || _isLoading.value;

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
      function = authController.login;
    } else {
      function = authController.register;
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
