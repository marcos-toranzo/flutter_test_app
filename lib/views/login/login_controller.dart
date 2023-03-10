import 'package:flutter/material.dart';
import 'package:flutter_test_app/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class LoginController extends GetxController {
  final AuthController _authController;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginController(this._authController);

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  final _isLoading = false.obs;
  bool get isLoading => _authController.isLoading || _isLoading.value;

  void onLoginPressed({
    Callback? onErrorLogingIn,
    Callback? onSuccessfulLogin,
  }) async {
    _isLoading.value = true;

    await Future.delayed(const Duration(seconds: 2));

    onSuccessfulLogin?.call();

    _isLoading.value = false;
  }
}
