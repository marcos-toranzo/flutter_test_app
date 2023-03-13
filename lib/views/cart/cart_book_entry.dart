import 'package:flutter_test_app/models/book.dart';

class CartBookEntry {
  final Book book;
  final int count;

  const CartBookEntry({required this.book, required this.count});
}
