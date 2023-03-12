import 'package:flutter_test_app/models/book.dart';
import 'package:flutter_test_app/models/model.dart';

class Cart extends Model {
  final List<Book> books;

  const Cart({
    required super.id,
    this.books = const [],
  });
}
