import 'package:flutter/material.dart';
import 'package:flutter_test_app/api/book_repository.dart';
import 'package:flutter_test_app/models/book.dart';
import 'package:get/get.dart';

class BookController extends GetxController {
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final _book = Rx<Book?>(null);
  Book? get book => _book.value;

  final VoidCallback? _onErrorFetchingBook;
  final String _bookId;

  BookController({
    required String bookId,
    void Function()? onErrorFetchingBook,
  })  : _bookId = bookId,
        _onErrorFetchingBook = onErrorFetchingBook;

  @override
  void onInit() {
    super.onInit();

    _loadBooks(onError: _onErrorFetchingBook);
  }

  Future<void> _loadBooks({VoidCallback? onError}) async {
    _isLoading.value = true;

    final bookFetchingResult = await BookRepository.fetchBook(_bookId);

    if (bookFetchingResult.success) {
      _book.value = bookFetchingResult.data!;
    } else {
      onError?.call();
    }

    _isLoading.value = false;
  }

  void onRefresh({VoidCallback? onError}) {
    _loadBooks(onError: onError ?? _onErrorFetchingBook);
  }
}
