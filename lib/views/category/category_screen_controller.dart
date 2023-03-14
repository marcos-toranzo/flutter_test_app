import 'package:flutter/material.dart';
import 'package:flutter_test_app/api/book_repository.dart';
import 'package:flutter_test_app/models/book.dart';
import 'package:flutter_test_app/utils/book_category.dart';
import 'package:flutter_test_app/utils/sorting.dart';
import 'package:get/get.dart';

class CategoryScreenController extends GetxController {
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final _bookCategory = Rx<BookCategory?>(null);
  BookCategory? get bookCategory => _bookCategory.value;

  List<Book> _unorderedBooks = [];

  final VoidCallback? onErrorFetchingBooks;
  final String categoryName;

  CategoryScreenController({
    required this.categoryName,
    this.onErrorFetchingBooks,
  });

  @override
  void onInit() {
    super.onInit();

    _loadBooks(onError: onErrorFetchingBooks);
  }

  Future<void> _loadBooks({VoidCallback? onError}) async {
    _isLoading.value = true;

    final categoryBooksResult = await BookRepository.searchBooks(
      searchTerm: categoryName,
    );

    if (categoryBooksResult.success) {
      final categoryBooks = categoryBooksResult.data!;

      _bookCategory.value = BookCategory(
        name: categoryName,
        books: categoryBooks,
      );

      _unorderedBooks = categoryBooks;
    } else {
      onError?.call();
    }

    _isLoading.value = false;
  }

  void onRefresh({VoidCallback? onError}) {
    _loadBooks(onError: onError ?? onErrorFetchingBooks);
  }

  void onSortByPrice(SortOrder sortOrder) {
    final sortedBooks = sortOrder == SortOrder.none
        ? _unorderedBooks
        : sortBooksByPrice(_bookCategory.value!.books, sortOrder);

    _bookCategory.value = BookCategory(
      name: _bookCategory.value!.name,
      books: sortedBooks,
    );
  }
}
