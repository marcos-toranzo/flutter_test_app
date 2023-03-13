import 'package:flutter/material.dart';
import 'package:flutter_test_app/app_configuration.dart';
import 'package:flutter_test_app/models/book.dart';
import 'package:flutter_test_app/services/routing_service/routing_service.dart';
import 'package:flutter_test_app/utils/localization.dart';
import 'package:flutter_test_app/utils/styling.dart';
import 'package:flutter_test_app/views/book/book_screen.dart';
import 'package:flutter_test_app/widgets/book/book_image.dart';
import 'package:flutter_test_app/widgets/book/book_price_tag.dart';
import 'package:flutter_test_app/widgets/column_with_padding.dart';
import 'package:flutter_test_app/widgets/cutom_text.dart';
import 'package:flutter_test_app/widgets/buttons/ink_well_button.dart';
import 'package:flutter_test_app/widgets/space.dart';

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

    return InkWellButton(
      onTap: () {
        routingService.pushRoute(
          context: context,
          routeName: BookScreen.routeName,
          routeArguments: RouteArguments(
            bookId: book.id,
            transition: ScreenTransitions.slide,
          ),
        );
      },
      borderRadius: borderRadius,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withAlpha(40),
          borderRadius: borderRadius,
        ),
        child: ColumnWithPadding(
          padding: const EdgeInsets.all(8),
          children: [
            Expanded(
              child: BookImage(
                imageUrl: book.imageLink,
                elevation: 2,
                width: imageWidth,
                fit: BoxFit.cover,
              ),
            ),
            const Space.vertical(5),
            SizedBox(
              width: imageWidth,
              child: OnBackgroundText(
                book.title ?? translations.untitled,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Space.vertical(15),
            BookPriceTag(price: book.price, saleability: book.saleability),
          ],
        ),
      ),
    );
  }
}
