import 'package:flutter/foundation.dart';
import 'package:flutter_test_app/api/book_repository.dart';
import 'package:flutter_test_app/models/book.dart';
import 'package:get/get.dart';

class BookCategory {
  final String name;
  final List<Book> books;

  const BookCategory({required this.name, required this.books});
}

class HomeController extends GetxController {
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final _bookCategories = RxList<BookCategory>([]);
  List<BookCategory> get bookCategories => _bookCategories;

  final VoidCallback? onErrorFetchingBooks;

  HomeController({this.onErrorFetchingBooks});

  @override
  void onInit() {
    super.onInit();

    loadBooks(onError: onErrorFetchingBooks);
  }

  Future<void> loadBooks({VoidCallback? onError}) async {
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
        maxResults: 20,
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
    loadBooks(onError: onError);
  }
}
