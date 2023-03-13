import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test_app/models/book.dart';
import 'package:flutter_test_app/utils/currency.dart';
import 'package:flutter_test_app/utils/localization.dart';
import 'package:flutter_test_app/utils/styling.dart';

class BookPriceTag extends StatelessWidget {
  final Currency? price;
  final BookSaleability saleability;
  final double size;

  const BookPriceTag({
    required this.price,
    this.size = 14,
    this.saleability = BookSaleability.forSale,
    super.key,
  }) : assert(size > 4);

  @override
  Widget build(BuildContext context) {
    final translations = AppTranslations.of(context);

    var priceText = '-';
    var priceTextStyle = TextStyle(
      fontSize: size - 4,
      color: Theme.of(context).colorScheme.onPrimary,
    );

    if (price != null) {
      priceText = price!.format();
      priceTextStyle = priceTextStyle.copyWith(fontSize: size);
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
      color: Colors.transparent,
      elevation: 2,
      child: Chip(
        label: Text(priceText),
        side: BorderSide.none,
        backgroundColor: Theme.of(context).primaryColor,
        labelPadding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: max(size - 14.0, 0.0),
        ),
        visualDensity: VisualDensity.compact,
        padding: EdgeInsets.zero,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        labelStyle: priceTextStyle,
      ),
    );
  }
}
