import 'package:flutter_test_app/models/book.dart';

enum SortOrder {
  ascending,
  descending,
  none,
}

List<Book> sortBooksByPrice(List<Book> books, SortOrder sortOrder) {
  int ascendingComparator(Book book1, Book book2) {
    if (book1.saleability == book2.saleability) {
      return book1.saleability == BookSaleability.forSale
          ? book1.price!.compareTo(book2.price!)
          : 0;
    }

    if (book1.saleability == BookSaleability.free) {
      return book2.saleability == BookSaleability.notForSale ? 1 : -1;
    }

    return book1.saleability == BookSaleability.notForSale ? -1 : 1;
  }

  int descendingComparator(Book book1, Book book2) =>
      ascendingComparator(book2, book1);

  return [...books]..sort(sortOrder == SortOrder.ascending
      ? ascendingComparator
      : descendingComparator);
}
