import 'package:flutter/material.dart';
import 'package:flutter_test_app/app_configuration.dart';
import 'package:flutter_test_app/services/routing_service/routing_service.dart';
import 'package:flutter_test_app/utils/localization.dart';
import 'package:flutter_test_app/utils/notifications.dart';
import 'package:flutter_test_app/utils/styling.dart';
import 'package:flutter_test_app/views/book/book_screen.dart';
import 'package:flutter_test_app/views/cart/cart_book_entry.dart';
import 'package:flutter_test_app/views/cart/cart_entry_widget/add_remove_book/add_remove_book.dart';
import 'package:flutter_test_app/views/cart/cart_entry_widget/cart_book_title_and_authors.dart';
import 'package:flutter_test_app/views/cart/cart_screen_controller.dart';
import 'package:flutter_test_app/widgets/book/book_image.dart';
import 'package:flutter_test_app/widgets/book/book_price_tag.dart';
import 'package:flutter_test_app/widgets/buttons/ink_well_button.dart';
import 'package:flutter_test_app/widgets/row_with_padding.dart';
import 'package:flutter_test_app/widgets/simple_card.dart';
import 'package:flutter_test_app/widgets/space.dart';
import 'package:get/get.dart';

class CartEntryWidget extends StatelessWidget {
  final CartBookEntry entry;
  final VoidCallback? onRemoveBookError;

  final CartScreenController _cartScreenController = Get.find();

  CartEntryWidget({
    required this.entry,
    this.onRemoveBookError,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final translations = AppTranslations.of(context);
    final book = entry.book;

    final borderRadius = BorderRadius.circular(borderRadiusValue);

    return SimpleCard(
      borderRadius: borderRadius,
      elevation: 0.5,
      child: InkWellButton(
        borderRadius: borderRadius,
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
        child: SizedBox(
          height: 200,
          child: RowWithPadding(
            crossAxisAlignment: CrossAxisAlignment.start,
            padding: const EdgeInsets.all(12),
            children: [
              BookImage(imageUrl: book.imageLink),
              const Space.horizontal(10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CartBookTitleAndAuthors(
                      title: book.title,
                      authors: book.authors,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BookPriceTag(
                          price: book.price,
                          saleability: book.saleability,
                        ),
                        const Space.vertical(10),
                        AddRemoveBook(
                          count: entry.count,
                          isEditingCount: _cartScreenController.isEditingCount,
                          onMinusPressed: () {
                            _cartScreenController.removeBook(
                              book.id,
                              onError: () {
                                showSnackBar(
                                  context: context,
                                  text: translations.errorRemovingFromCart,
                                );
                              },
                            );
                          },
                          onPlusPressed: () {
                            _cartScreenController.addBook(
                              book.id,
                              onError: () {
                                showSnackBar(
                                  context: context,
                                  text: translations.errorAddingToCart,
                                );
                              },
                            );
                          },
                          onRemovePressed: () {
                            _cartScreenController.removeBook(
                              book.id,
                              count: entry.count,
                              onError: onRemoveBookError,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
