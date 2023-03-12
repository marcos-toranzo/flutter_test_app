import 'package:flutter/material.dart';
import 'package:flutter_test_app/models/book.dart';
import 'package:flutter_test_app/utils/localization.dart';
import 'package:flutter_test_app/utils/styling.dart';
import 'package:flutter_test_app/widgets/column_with_padding.dart';
import 'package:flutter_test_app/widgets/space.dart';
import 'package:intl/intl.dart';

class BookPreview extends StatelessWidget {
  final Book book;

  const BookPreview({
    required this.book,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final translations = AppTranslations.of(context);

    const imageWidth = 100.0;
    final borderRadius = BorderRadius.circular(borderRadiusValue);

    var price = '-';
    var priceStyle = TextStyle(
      fontSize: 10,
      color: Theme.of(context).colorScheme.onPrimary,
    );

    if (book.price != null) {
      final formatter = NumberFormat.simpleCurrency(
        decimalDigits: 2,
        name: book.price!.code,
      );

      price = formatter.format(book.price!.amount);
      priceStyle = priceStyle.copyWith(
        fontSize: 14,
      );
    } else {
      final saleability = book.saleability;

      switch (saleability) {
        case BookSaleability.free:
          price = translations.free;
          break;
        case BookSaleability.notForSale:
          price = translations.notForSale;
          break;
        default:
      }
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: borderRadius,
        splashColor: Theme.of(context).primaryColor.withAlpha(100),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withAlpha(40),
            borderRadius: borderRadius,
          ),
          child: ColumnWithPadding(
            padding: const EdgeInsets.all(8),
            children: [
              Expanded(
                child: Material(
                  borderRadius: borderRadius,
                  elevation: 2,
                  child: ClipRRect(
                    borderRadius: borderRadius,
                    child: book.imageLink != null
                        ? Image.network(
                            book.imageLink!,
                            width: imageWidth,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/images/book_cover_placeholder.png',
                            width: imageWidth,
                          ),
                  ),
                ),
              ),
              const Space.vertical(5),
              SizedBox(
                width: imageWidth,
                child: Text(
                  book.title ?? translations.untitled,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ),
              const Space.vertical(15),
              Material(
                borderRadius: borderRadius,
                elevation: 2,
                child: Chip(
                  label: Text(price),
                  side: BorderSide.none,
                  backgroundColor: Theme.of(context).primaryColor,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 10),
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(borderRadius: borderRadius),
                  labelStyle: priceStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
