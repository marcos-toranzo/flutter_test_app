import 'package:flutter/material.dart';
import 'package:flutter_test_app/api/book_repository.dart';
import 'package:flutter_test_app/utils/book_category.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final _bookCategory = Rx<BookCategory?>(null);
  BookCategory? get bookCategory => _bookCategory.value;

  final VoidCallback? _onErrorFetchingBooks;
  final String _categoryName;

  CategoryController({
    required String categoryName,
    void Function()? onErrorFetchingBooks,
  })  : _categoryName = categoryName,
        _onErrorFetchingBooks = onErrorFetchingBooks;

  @override
  void onInit() {
    super.onInit();

    _loadBooks(onError: _onErrorFetchingBooks);
  }

  Future<void> _loadBooks({VoidCallback? onError}) async {
    _isLoading.value = true;

    final categoryBooksResult = await BookRepository.searchBooks(
      searchTerm: _categoryName,
    );

    if (categoryBooksResult.success) {
      final categoryBooks = categoryBooksResult.data!;

      _bookCategory.value = BookCategory(
        name: _categoryName,
        books: categoryBooks,
      );
    } else {
      onError?.call();
    }

    _isLoading.value = false;
  }

  void onRefresh({VoidCallback? onError}) {
    _loadBooks(onError: onError ?? _onErrorFetchingBooks);
  }
}
