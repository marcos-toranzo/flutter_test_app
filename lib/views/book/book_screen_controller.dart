import 'package:flutter/material.dart';
import 'package:flutter_test_app/api/book_repository.dart';
import 'package:flutter_test_app/controllers/cart_controller.dart';
import 'package:flutter_test_app/models/book.dart';
import 'package:get/get.dart';

class BookScreenController extends GetxController {
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final _book = Rx<Book?>(null);
  Book? get book => _book.value;

  final VoidCallback? onErrorFetchingBook;
  final String bookId;
  final CartController cartController;

  BookScreenController({
    required this.bookId,
    required this.cartController,
    this.onErrorFetchingBook,
  });

  @override
  void onInit() {
    super.onInit();

    _loadBooks(onError: onErrorFetchingBook);
  }

  Future<void> _loadBooks({VoidCallback? onError}) async {
    _isLoading.value = true;

    final bookFetchingResult = await BookRepository.fetchBook(bookId);

    if (bookFetchingResult.success) {
      _book.value = bookFetchingResult.data!;
    } else {
      onError?.call();
    }

    _isLoading.value = false;
  }

  void onRefresh({VoidCallback? onError}) {
    _loadBooks(onError: onError ?? onErrorFetchingBook);
  }

  Future<void> onAddToCart({
    VoidCallback? onError,
    VoidCallback? onSuccess,
  }) async {
    _isLoading.value = true;

    await cartController.addBook(
      book!.id,
      onError: onError,
      onSuccess: onSuccess,
    );

    _isLoading.value = false;
  }
}
