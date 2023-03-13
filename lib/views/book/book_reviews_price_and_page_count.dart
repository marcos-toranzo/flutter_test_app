import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_test_app/models/book.dart';
import 'package:flutter_test_app/utils/currency.dart';
import 'package:flutter_test_app/utils/localization.dart';
import 'package:flutter_test_app/widgets/book/book_price_tag.dart';
import 'package:flutter_test_app/widgets/cutom_text.dart';
import 'package:flutter_test_app/widgets/space.dart';

class BookPriceReviewAndPageCount extends StatelessWidget {
  final Currency? price;
  final BookSaleability saleability;
  final BookRatings? ratings;
  final int? pageCount;

  const BookPriceReviewAndPageCount({
    required this.price,
    required this.saleability,
    required this.ratings,
    required this.pageCount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final translations = AppTranslations.of(context);

    return Row(
      children: [
        Expanded(
          child: Center(
            child: ratings == null
                ? OnBackgroundText(translations.nReviews(0))
                : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RatingBar.builder(
                            initialRating: ratings!.average ?? 0,
                            minRating: 1,
                            maxRating: 5,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemBuilder: (_, __) => Icon(
                              Icons.star,
                              color: Theme.of(context).primaryColor,
                            ),
                            itemSize: 16,
                            onRatingUpdate: (_) {},
                            ignoreGestures: true,
                          ),
                          const Space.horizontal(5),
                          OnBackgroundText(
                              ratings!.average?.toString() ?? '0.0')
                        ],
                      ),
                      OnBackgroundText(
                          translations.nReviews(ratings!.count ?? 0))
                    ],
                  ),
          ),
        ),
        BookPriceTag(
          price: price,
          saleability: saleability,
        ),
        Expanded(
          child: OnBackgroundText(
            translations.nPages(pageCount?.toString() ?? '?'),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
