import 'package:flutter/material.dart';
import 'package:flutter_test_app/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

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

  void onLoginPressed({
    Callback? onError,
    Callback? onSuccess,
  }) async {
    _isLoading.value = true;

    await Future.delayed(const Duration(seconds: 2));

    onSuccess?.call();

    _isLoading.value = false;
  }

  void onSignUpPressed({
    Callback? onError,
    Callback? onSuccess,
  }) async {
    _isLoading.value = true;

    await Future.delayed(const Duration(seconds: 2));

    onSuccess?.call();

    _isLoading.value = false;
  }

  void changeMode() {
    repeatPasswordController.clear();
    _isLogingIn.value = !isLogingIn;
  }
}
