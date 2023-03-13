import 'package:flutter/material.dart';
import 'package:flutter_test_app/controllers/cart_controller.dart';
import 'package:get/get.dart';

class CheckoutScreenController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardHolderNameController =
      TextEditingController();
  final TextEditingController cardExpDateController = TextEditingController();
  final TextEditingController cardCVCController = TextEditingController();

  final CartController cartController;

  CheckoutScreenController({required this.cartController});

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value || cartController.isLoading;

  @override
  void onClose() {
    nameController.dispose();
    addressController.dispose();
    countryController.dispose();
    cityController.dispose();
    zipCodeController.dispose();
    cardNumberController.dispose();
    cardHolderNameController.dispose();
    cardExpDateController.dispose();
    cardCVCController.dispose();

    super.onClose();
  }

  Future<void> onSubmit({
    VoidCallback? onError,
    VoidCallback? onSuccess,
  }) =>
      cartController.emptyCart(
        onError: onError,
        onSuccess: onSuccess,
      );
}
