import 'package:flutter/material.dart';
import 'package:flutter_test_app/models/book.dart';
import 'package:flutter_test_app/utils/currency.dart';
import 'package:flutter_test_app/utils/localization.dart';
import 'package:flutter_test_app/utils/styling.dart';
import 'package:intl/intl.dart';

class BookPriceTag extends StatelessWidget {
  final Currency? price;
  final BookSaleability saleability;

  const BookPriceTag({
    required this.price,
    required this.saleability,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final translations = AppTranslations.of(context);

    var priceText = '-';
    var priceTextStyle = TextStyle(
      fontSize: 10,
      color: Theme.of(context).colorScheme.onPrimary,
    );

    if (price != null) {
      final formatter = NumberFormat.simpleCurrency(
        decimalDigits: 2,
        name: price!.code,
      );

      priceText = formatter.format(price!.amount);
      priceTextStyle = priceTextStyle.copyWith(
        fontSize: 14,
      );
    } else {
      switch (saleability) {
        case BookSaleability.free:
          priceText = translations.free;
          break;
        case BookSaleability.notForSale:
          priceText = translations.notForSale;
          break;
        default:
      }
    }

    final borderRadius = BorderRadius.circular(borderRadiusValue);

    return Material(
      borderRadius: borderRadius,
      elevation: 2,
      child: Chip(
        label: Text(priceText),
        side: BorderSide.none,
        backgroundColor: Theme.of(context).primaryColor,
        labelPadding: const EdgeInsets.symmetric(horizontal: 10),
        visualDensity: VisualDensity.compact,
        padding: EdgeInsets.zero,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        labelStyle: priceTextStyle,
      ),
    );
  }
}
