import 'package:flutter_test_app/models/book.dart';

class BookCategory {
  final String name;
  final List<Book> books;

  const BookCategory({required this.name, required this.books});
}
