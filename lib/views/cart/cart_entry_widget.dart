import 'package:flutter/material.dart';
import 'package:flutter_test_app/app_configuration.dart';
import 'package:flutter_test_app/services/routing_service/routing_service.dart';
import 'package:flutter_test_app/utils/iterable_utils.dart';
import 'package:flutter_test_app/utils/localization.dart';
import 'package:flutter_test_app/utils/notifications.dart';
import 'package:flutter_test_app/utils/styling.dart';
import 'package:flutter_test_app/views/book/book_screen.dart';
import 'package:flutter_test_app/views/cart/cart_book_entry.dart';
import 'package:flutter_test_app/views/cart/cart_screen_controller.dart';
import 'package:flutter_test_app/widgets/book_image.dart';
import 'package:flutter_test_app/widgets/book_price_tag.dart';
import 'package:flutter_test_app/widgets/custom_button.dart';
import 'package:flutter_test_app/widgets/cutom_text.dart';
import 'package:flutter_test_app/widgets/ink_well_button.dart';
import 'package:flutter_test_app/widgets/row_with_padding.dart';
import 'package:flutter_test_app/widgets/simple_card.dart';
import 'package:flutter_test_app/widgets/space.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CartEntryWidget extends StatelessWidget {
  final CartBookEntry entry;

  final CartScreenController _cartScreenController = Get.find();

  CartEntryWidget({required this.entry, super.key});

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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        OnBackgroundText(
                          book.title ?? translations.untitled,
                          maxLines: 3,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        ...(book.authors != null
                            ? book.authors!.mapList(
                                (author) => OnBackgroundText(author),
                              )
                            : [OnBackgroundText(translations.unknownAuthors)]),
                      ],
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
                        RowWithPadding(
                          padding: const EdgeInsets.all(2),
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _BookCounter(
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
                              count: entry.count,
                            ),
                            CustomButton(
                              onPressed: () {
                                _cartScreenController.removeBook(
                                  book.id,
                                  count: entry.count,
                                  onError: () {
                                    showSnackBar(
                                      context: context,
                                      text: translations.errorAddingToCart,
                                    );
                                  },
                                );
                              },
                              text: translations.remove,
                              iconData: FontAwesomeIcons.trash,
                              borderRadius: borderRadius,
                            ),
                          ],
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

class _CounterButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool enabled;
  final IconData iconData;

  const _CounterButton({
    required this.onTap,
    required this.iconData,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enabled ? onTap : () {},
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Icon(
          iconData,
          color: enabled
              ? Theme.of(context).primaryColor
              : Theme.of(context).disabledColor,
          size: 15,
        ),
      ),
    );
  }
}

class _BookCounter extends StatelessWidget {
  final VoidCallback onMinusPressed;
  final VoidCallback onPlusPressed;
  final int count;

  const _BookCounter({
    required this.onMinusPressed,
    required this.onPlusPressed,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _CounterButton(
          onTap: onMinusPressed,
          iconData: FontAwesomeIcons.chevronLeft,
          enabled: count > 1,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: OnBackgroundText(count.toString()),
        ),
        _CounterButton(
          onTap: onPlusPressed,
          iconData: FontAwesomeIcons.chevronRight,
        ),
      ],
    );
  }
}
