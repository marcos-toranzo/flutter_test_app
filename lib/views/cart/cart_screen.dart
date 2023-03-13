import 'package:flutter/material.dart';
import 'package:flutter_test_app/controllers/cart_controller.dart';
import 'package:flutter_test_app/utils/iterable_utils.dart';
import 'package:flutter_test_app/utils/localization.dart';
import 'package:flutter_test_app/utils/notifications.dart';
import 'package:flutter_test_app/views/cart/cart_entry_widget.dart';
import 'package:flutter_test_app/views/cart/cart_screen_controller.dart';
import 'package:flutter_test_app/widgets/book/book_price_tag.dart';
import 'package:flutter_test_app/widgets/custom_appbar.dart';
import 'package:flutter_test_app/widgets/page_with_loader.dart';
import 'package:flutter_test_app/widgets/buttons/wide_button.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = '/cart';

  final CartController _cartController = Get.find();

  CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final translations = AppTranslations.of(context);

    final controller = Get.put(
      CartScreenController(
        cartController: _cartController,
        onErrorFetchingBooks: () {
          showSnackBar(context: context, text: translations.errorFetchingBooks);
        },
      ),
    );

    return Obx(
      () {
        return PageWithLoader(
          loaderText: translations.loading,
          showLoader: controller.isLoading,
          child: Scaffold(
            appBar: CustomAppBar(
              titleText: translations.cart,
              onRefresh: controller.onRefresh,
              showCartButton: false,
            ),
            floatingActionButton: _cartController.totalCount > 0
                ? _CartCheckoutFAB(controller: controller)
                : null,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            body: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(
                top: 8.0,
                right: 8.0,
                left: 8.0,
                bottom: 100,
              ),
              children: controller.cartBooksEntries.mapList(
                (entry) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: CartEntryWidget(entry: entry),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _CartCheckoutFAB extends StatelessWidget {
  final CartScreenController controller;

  const _CartCheckoutFAB({required this.controller});

  @override
  Widget build(BuildContext context) {
    final translations = AppTranslations.of(context);

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor.withAlpha(220),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${translations.total}: ',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                BookPriceTag(
                  price: controller.total,
                  size: 16,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: WideButton(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              text: translations.checkout,
              // TODO: go to checkout screen
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
