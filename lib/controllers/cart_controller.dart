import 'package:flutter/material.dart';
import 'package:flutter_test_app/api/cart_repository.dart';
import 'package:flutter_test_app/models/cart.dart';
import 'package:flutter_test_app/utils/iterable_utils.dart';
import 'package:flutter_test_app/utils/types.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final _cart = Rx<Cart?>(null);
  Cart? get cart => _cart.value;

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  int get totalCount =>
      cart?.entries
          .reduceAndCompute<int>((acc, entry) => acc + entry.count, 0) ??
      0;

  Future<bool> fetchCart({
    required Id id,
    VoidCallback? onError,
    VoidCallback? onSuccess,
  }) async {
    _isLoading.value = true;

    final response = await CartRepository.fetchCart(id);

    if (response.success) {
      _cart.value = response.data!;

      onSuccess?.call();
      _isLoading.value = false;

      return true;
    }

    onError?.call();
    _isLoading.value = false;

    return false;
  }

  Future<bool> addBook(
    Id id, {
    VoidCallback? onError,
    VoidCallback? onSuccess,
  }) async {
    _isLoading.value = true;

    final response = await CartRepository.addBook(id);

    if (response.success) {
      _cart.value = response.data!;

      onSuccess?.call();
      _isLoading.value = false;

      return true;
    }

    onError?.call();
    _isLoading.value = false;

    return false;
  }

  Future<bool> removeBook(
    Id id, {
    int count = 1,
    VoidCallback? onError,
    VoidCallback? onSuccess,
  }) async {
    _isLoading.value = true;

    final response = await CartRepository.removeBook(id, count);

    if (response.success) {
      _cart.value = response.data!;

      onSuccess?.call();
      _isLoading.value = false;

      return true;
    }

    onError?.call();
    _isLoading.value = false;

    return false;
  }
}
