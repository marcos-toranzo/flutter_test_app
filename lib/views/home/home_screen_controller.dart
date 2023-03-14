import 'package:flutter/foundation.dart';
import 'package:flutter_test_app/api/book_repository.dart';
import 'package:flutter_test_app/utils/book_category.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final _bookCategories = RxList<BookCategory>([]);
  List<BookCategory> get bookCategories => _bookCategories;

  final VoidCallback? onErrorFetchingBooks;

  HomeScreenController({this.onErrorFetchingBooks});

  @override
  void onInit() {
    super.onInit();

    _loadBooks(onError: onErrorFetchingBooks);
  }

  Future<void> _loadBooks({VoidCallback? onError}) async {
    _isLoading.value = true;

    _bookCategories.value = [];

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

    for (var category in categories) {
      final categoryBooksResult = await BookRepository.searchBooks(
        searchTerm: category,
        maxResults: 10,
      );

      if (categoryBooksResult.success) {
        final categoryBooks = categoryBooksResult.data!;

        _bookCategories.value = [
          ..._bookCategories,
          BookCategory(
            name: category,
            books: categoryBooks,
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
}
