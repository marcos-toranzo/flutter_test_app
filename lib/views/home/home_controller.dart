import 'package:flutter/foundation.dart';
import 'package:flutter_test_app/api/book_repository.dart';
import 'package:flutter_test_app/utils/book_category.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final _bookCategories = RxList<BookCategory>([]);
  List<BookCategory> get bookCategories => _bookCategories;

  final VoidCallback? _onErrorFetchingBooks;

  HomeController({void Function()? onErrorFetchingBooks})
      : _onErrorFetchingBooks = onErrorFetchingBooks;

  @override
  void onInit() {
    super.onInit();

    _loadBooks(onError: _onErrorFetchingBooks);
  }

  Future<void> _loadBooks({VoidCallback? onError}) async {
    _isLoading.value = true;

    const categories = [
      'Fiction',
      'Sports',
      'Poetry',
      'History',
      'Education',
      'Romance',
      'Fantasy',
      'Crime',
    ];

    final bookCategoriesFetched = <BookCategory>[];

    for (var category in categories) {
      final categoryBooksResult = await BookRepository.searchBooks(
        searchTerm: category,
        maxResults: 10,
      );

      if (categoryBooksResult.success) {
        final categoryBooks = categoryBooksResult.data!;

        bookCategoriesFetched.add(
          BookCategory(
            name: category,
            books: categoryBooks,
          ),
        );
      } else {
        onError?.call();
        _isLoading.value = false;
        return;
      }
    }

    _bookCategories.value = bookCategoriesFetched;

    _isLoading.value = false;
  }

  void onRefresh({VoidCallback? onError}) {
    _loadBooks(onError: onError ?? _onErrorFetchingBooks);
  }
}
