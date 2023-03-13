import 'package:flutter/material.dart';
import 'package:flutter_test_app/controllers/cart_controller.dart';
import 'package:flutter_test_app/utils/iterable_utils.dart';
import 'package:flutter_test_app/utils/localization.dart';
import 'package:flutter_test_app/utils/notifications.dart';
import 'package:flutter_test_app/views/cart/cart_entry_widget.dart';
import 'package:flutter_test_app/views/cart/cart_screen_controller.dart';
import 'package:flutter_test_app/widgets/custom_appbar.dart';
import 'package:flutter_test_app/widgets/page_with_loader.dart';
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
            body: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(8.0),
              children: controller.cartBooksEntries.mapList(
                (entry) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: CartEntryWidget(
                    entry: entry,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
