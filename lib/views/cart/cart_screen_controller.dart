import 'package:flutter/material.dart';
import 'package:flutter_test_app/api/book_repository.dart';
import 'package:flutter_test_app/controllers/cart_controller.dart';
import 'package:flutter_test_app/utils/currency.dart';
import 'package:flutter_test_app/utils/iterable_utils.dart';
import 'package:flutter_test_app/utils/types.dart';
import 'package:flutter_test_app/views/cart/cart_book_entry.dart';
import 'package:get/get.dart';

class CartScreenController extends GetxController {
  final VoidCallback? onErrorFetchingBooks;
  final CartController cartController;

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value || cartController.isLoading;

  final _cartBooksEntries = RxList<CartBookEntry>([]);
  List<CartBookEntry> get cartBooksEntries => _cartBooksEntries;

  Currency get total => _cartBooksEntries.reduceAndCompute(
        (acc, element) => Currency(
          amount:
              acc.amount + (element.book.price?.amount ?? 0) * element.count,
          code: element.book.price?.code ?? Currency.defaultCode,
        ),
        const Currency.zero(),
      );

  CartScreenController({
    required this.cartController,
    this.onErrorFetchingBooks,
  });

  @override
  void onInit() {
    super.onInit();

    _loadBooks(onError: onErrorFetchingBooks);
  }

  Future<void> _loadBooks({VoidCallback? onError}) async {
    _isLoading.value = true;

    _cartBooksEntries.value = [];

    for (var entry in cartController.cart!.entries) {
      final bookFetchingResult = await BookRepository.fetchBook(entry.bookId);

      if (bookFetchingResult.success) {
        final book = bookFetchingResult.data!;

        _cartBooksEntries.value = [
          ..._cartBooksEntries,
          CartBookEntry(
            book: book,
            count: entry.count,
          ),
        ];
      } else {
        onError?.call();
        _isLoading.value = false;
        return;
      }
    }

    _isLoading.value = false;
  }

  void onRefresh({VoidCallback? onError}) {
    _loadBooks(onError: onError ?? onErrorFetchingBooks);
  }

  Future<bool> addBook(
    Id id, {
    VoidCallback? onError,
  }) =>
      cartController.addBook(
        id,
        onError: onError,
        onSuccess: () {
          onRefresh(onError: onError);
        },
      );

  Future<bool> removeBook(
    Id id, {
    int count = 1,
    VoidCallback? onError,
  }) =>
      cartController.removeBook(
        id,
        count: count,
        onError: onError,
        onSuccess: () {
          onRefresh(onError: onError);
        },
      );
}
