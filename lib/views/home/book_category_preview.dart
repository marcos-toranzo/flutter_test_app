import 'package:flutter/material.dart';
import 'package:flutter_test_app/app_configuration.dart';
import 'package:flutter_test_app/services/routing_service/routing_service.dart';
import 'package:flutter_test_app/utils/book_category.dart';
import 'package:flutter_test_app/utils/localization.dart';
import 'package:flutter_test_app/utils/sorting.dart';
import 'package:flutter_test_app/utils/styling.dart';
import 'package:flutter_test_app/utils/types.dart';
import 'package:flutter_test_app/views/category/category_screen.dart';
import 'package:flutter_test_app/widgets/book/book_preview.dart';
import 'package:flutter_test_app/widgets/column_with_padding.dart';
import 'package:flutter_test_app/widgets/buttons/ink_well_button.dart';
import 'package:flutter_test_app/widgets/horizontally_scrollable_text.dart';
import 'package:flutter_test_app/widgets/row_with_padding.dart';
import 'package:flutter_test_app/widgets/simple_card.dart';
import 'package:flutter_test_app/widgets/sort_by_price_button.dart';
import 'package:flutter_test_app/widgets/space.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BookCategoryPreview extends StatelessWidget {
  final BookCategory bookCategory;
  final double paddingValue;
  final SortOrder sortOrder;
  final OnChangedCallback<SortOrder>? onSort;

  const BookCategoryPreview({
    required this.bookCategory,
    required this.paddingValue,
    this.sortOrder = SortOrder.none,
    this.onSort,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final translations = AppTranslations.of(context);
    final borderRadius = BorderRadius.circular(borderRadiusValue);
    final theme = Theme.of(context);

    goToCategoryView() {
      routingService.pushRoute(
        context: context,
        routeName: CategoryScreen.routeName,
        routeArguments: RouteArguments(
          transition: ScreenTransitions.slide,
          categoryName: bookCategory.name,
        ),
      );
    }

    return SimpleCard(
      elevation: 0.5,
      borderRadius: borderRadius,
      child: InkWellButton(
        onTap: goToCategoryView,
        borderRadius: borderRadius,
        child: ColumnWithPadding(
          padding: EdgeInsets.only(top: 10, bottom: paddingValue),
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            RowWithPadding(
              padding: EdgeInsets.symmetric(horizontal: paddingValue),
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: HorizontallyScrollableText.onBackground(
                    translations.categoryName(bookCategory.name),
                    style: theme.textTheme.titleLarge,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (onSort != null) SortByPriceButton(onSort: onSort!),
                  ],
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
                          key: Key('book#${bookCategory.books[index].id}'),
                          book: bookCategory.books[index],
                        )
                      : InkWellButton(
                          transparent: false,
                          onTap: goToCategoryView,
                          borderRadius: borderRadius,
                          child: SizedBox(
                            width: 100,
                            child: Icon(
                              FontAwesomeIcons.chevronRight,
                              color: theme.primaryColor,
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
