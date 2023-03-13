import 'package:flutter/material.dart';
import 'package:flutter_test_app/api/book_repository.dart';
import 'package:flutter_test_app/controllers/cart_controller.dart';
import 'package:flutter_test_app/utils/currency.dart';
import 'package:flutter_test_app/utils/iterable_utils.dart';
import 'package:flutter_test_app/utils/types.dart';
import 'package:flutter_test_app/views/cart/cart_book_entry.dart';
import 'package:get/get.dart';

class CartScreenController extends GetxController {
  final VoidCallback? _onErrorFetchingBooks;
  final CartController _cartController;

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value || _cartController.isLoading;

  final _cartBooksEntries = RxList<CartBookEntry>([]);
  List<CartBookEntry> get cartBooksEntries => _cartBooksEntries;

  Currency get total => _cartBooksEntries.reduceAndCompute(
        (acc, element) => Currency(
          amount: acc.amount + (element.book.price?.amount ?? 0),
          code: element.book.price?.code ?? '',
        ),
        const Currency.none(),
      );

  CartScreenController({
    required CartController cartController,
    void Function()? onErrorFetchingBooks,
  })  : _cartController = cartController,
        _onErrorFetchingBooks = onErrorFetchingBooks;

  @override
  void onInit() {
    super.onInit();

    _loadBooks(onError: _onErrorFetchingBooks);
  }

  Future<void> _loadBooks({VoidCallback? onError}) async {
    _isLoading.value = true;

    final newCartBookEntries = <CartBookEntry>[];

    for (var entry in _cartController.cart!.entries) {
      final bookFetchingResult = await BookRepository.fetchBook(entry.bookId);

      if (bookFetchingResult.success) {
        final book = bookFetchingResult.data!;

        newCartBookEntries.add(
          CartBookEntry(
            book: book,
            count: entry.count,
          ),
        );
      } else {
        onError?.call();
        _isLoading.value = false;
        return;
      }
    }

    _cartBooksEntries.value = newCartBookEntries;

    _isLoading.value = false;
  }

  void onRefresh({VoidCallback? onError}) {
    _loadBooks(onError: onError ?? _onErrorFetchingBooks);
  }

  Future<bool> addBook(
    Id id, {
    VoidCallback? onError,
  }) =>
      _cartController.addBook(
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
      _cartController.removeBook(
        id,
        count: count,
        onError: onError,
        onSuccess: () {
          onRefresh(onError: onError);
        },
      );
}
