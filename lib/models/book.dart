import 'dart:convert';
import 'package:flutter_test_app/utils/currency.dart';

class BookRatings {
  final double? average;
  final int? count;

  const BookRatings({
    required this.average,
    required this.count,
  });
}

enum BookSaleability {
  forSale,
  free,
  notForSale,
  forPreorder,
}

class Book {
  final String id;
  final String? title;
  final List<String>? authors;
  final String? publisher;
  final String? publishedDate;
  final String? description;
  final int? pageCount;
  final List<String>? categories;
  final BookRatings? ratings;
  final String? imageLink;
  final String? language;
  final Currency? price;
  final BookSaleability saleability;

  const Book({
    required this.id,
    this.title,
    this.authors,
    this.publisher,
    this.publishedDate,
    this.description,
    this.pageCount,
    this.categories,
    this.ratings,
    this.imageLink,
    this.language,
    this.price,
    required this.saleability,
  });

  factory Book.fromMap(Map<String, dynamic> map) {
    final volumeInfo = map['volumeInfo'];

    final authors = volumeInfo['authors']?.cast<String>().toList();

    final categories = volumeInfo['categories']?.cast<String>().toList();

    final imageLinks = volumeInfo['imageLinks'];
    String? imageLink;

    if (imageLinks != null) {
      if (imageLinks['thumbnail'] != null) {
        imageLink = imageLinks['thumbnail'] as String;
      } else if (imageLinks['smallThumbnail'] != null) {
        imageLink = imageLinks['smallThumbnail'] as String;
      }
    }

    final saleInfo = map['saleInfo'];

    final retailPrice = saleInfo['retailPrice'];
    Currency? price;

    if (retailPrice != null) {
      price = Currency(
        amount: retailPrice['amount'].toDouble(),
        code: retailPrice['currencyCode'],
      );
    }

    final saleabilityData = saleInfo['saleability'];
    late final BookSaleability saleability;

    if (saleabilityData != null) {
      switch (saleabilityData) {
        case 'FOR_SALE':
          saleability = BookSaleability.forSale;
          break;
        case 'FREE':
          saleability = BookSaleability.free;
          break;
        case 'NOT_FOR_SALE':
          saleability = BookSaleability.notForSale;
          break;
        case 'FOR_PREORDER':
          saleability = BookSaleability.forPreorder;
          break;
        default:
          saleability = BookSaleability.notForSale;
      }
    }

    BookRatings? ratings;

    if (volumeInfo['averageRating'] != null ||
        volumeInfo['ratingsCount'] != null) {
      ratings = BookRatings(
        average: volumeInfo['averageRating'].toDouble(),
        count: volumeInfo['ratingsCount'],
      );
    }

    return Book(
      id: map['id'] as String,
      title: volumeInfo['title'],
      publisher: volumeInfo['publisher'],
      description: volumeInfo['description'],
      pageCount: volumeInfo['pageCount'],
      ratings: ratings,
      language: volumeInfo['language'],
      publishedDate: volumeInfo['publishedDate'],
      authors: authors,
      categories: categories,
      imageLink: imageLink,
      price: price,
      saleability: saleability,
    );
  }

  factory Book.fromJson(String source) =>
      Book.fromMap(json.decode(source) as Map<String, dynamic>);
}
