import 'package:flutter/material.dart';
import 'package:flutter_test_app/api/cart_repository.dart';
import 'package:flutter_test_app/models/cart.dart';
import 'package:flutter_test_app/models/cart_entry.dart';
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
    String id, {
    VoidCallback? onError,
    VoidCallback? onSuccess,
  }) async {
    _isLoading.value = true;

    final response = await CartRepository.addBook(
      cartId: cart!.id,
      bookId: id,
    );

    if (response.success) {
      final newEntry = response.data;

      late final List<CartEntry> newEntries;

      if (newEntry == null) {
        newEntries = cart!.entries.mapList(
          (entry) =>
              entry.bookId == id ? entry.copyWithCount(entry.count + 1) : entry,
        );
      } else {
        newEntries = [...cart!.entries, newEntry];
      }

      _cart.value = cart!.copyWithEntries(newEntries);

      onSuccess?.call();
      _isLoading.value = false;

      return true;
    }

    onError?.call();
    _isLoading.value = false;

    return false;
  }

  Future<bool> removeBook(
    String id, {
    int count = 1,
    VoidCallback? onError,
    VoidCallback? onSuccess,
  }) async {
    _isLoading.value = true;

    final response = await CartRepository.removeBook(
      cartId: cart!.id,
      bookId: id,
      count: count,
    );

    if (response.success) {
      final involvedEntry = response.data;

      late final List<CartEntry> newEntries;

      if (involvedEntry == null) {
        newEntries = cart!.entries.whereList((entry) => entry.bookId != id);
      } else {
        newEntries = cart!.entries.mapList(
          (entry) => entry.bookId == id
              ? entry.copyWithCount(entry.count - count)
              : entry,
        );
      }

      _cart.value = cart!.copyWithEntries(newEntries);

      onSuccess?.call();
      _isLoading.value = false;

      return true;
    }

    onError?.call();
    _isLoading.value = false;

    return false;
  }

  Future<bool> emptyCart({
    VoidCallback? onError,
    VoidCallback? onSuccess,
  }) async {
    _isLoading.value = true;

    final response = await CartRepository.empty(cart!.id);

    if (response.success) {
      _cart.value = cart!.copyWithEntries([]);

      onSuccess?.call();
      _isLoading.value = false;

      return true;
    }

    onError?.call();
    _isLoading.value = false;

    return false;
  }
}
