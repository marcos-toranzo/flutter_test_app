import 'package:flutter/material.dart';
import 'package:flutter_test_app/utils/localization.dart';
import 'package:flutter_test_app/utils/styling.dart';
import 'package:flutter_test_app/views/home/book_preview.dart';
import 'package:flutter_test_app/views/home/constants.dart';
import 'package:flutter_test_app/views/home/home_controller.dart';
import 'package:flutter_test_app/widgets/column_with_padding.dart';
import 'package:flutter_test_app/widgets/row_with_padding.dart';
import 'package:flutter_test_app/widgets/space.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BookCategoryView extends StatelessWidget {
  final BookCategory bookCategory;

  const BookCategoryView({required this.bookCategory, super.key});

  @override
  Widget build(BuildContext context) {
    final translations = AppTranslations.of(context);
    final borderRadius = BorderRadius.circular(borderRadiusValue);

    return Material(
      elevation: 0.5,
      borderRadius: borderRadius,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor.withAlpha(255),
          borderRadius: borderRadius,
        ),
        child: ColumnWithPadding(
          padding: const EdgeInsets.only(top: 10, bottom: paddingValue),
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            RowWithPadding(
              padding: const EdgeInsets.symmetric(horizontal: paddingValue),
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  translations.categoryName(bookCategory.name),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
                Material(
                  borderRadius: borderRadius,
                  child: InkWell(
                    onTap: () {},
                    borderRadius: borderRadius,
                    child: RowWithPadding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      children: [
                        Text(
                          translations.seeAll,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Space.horizontal(5),
                        Icon(
                          FontAwesomeIcons.chevronRight,
                          size: 10,
                          color: Theme.of(context).primaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Space.vertical(12),
            SizedBox(
              height: 200,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: bookCategory.books.length + 1,
                itemBuilder: (_, index) => Padding(
                  padding: EdgeInsets.only(
                    right: index == bookCategory.books.length
                        ? paddingValue
                        : paddingValue / 2,
                    left: index == 0 ? paddingValue : paddingValue / 2,
                  ),
                  child: index < bookCategory.books.length
                      ? BookPreview(
                          book: bookCategory.books[index],
                        )
                      : Material(
                          borderRadius: borderRadius,
                          child: InkWell(
                            onTap: () {},
                            borderRadius: borderRadius,
                            child: SizedBox(
                              width: 100,
                              child: Icon(
                                FontAwesomeIcons.chevronRight,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
