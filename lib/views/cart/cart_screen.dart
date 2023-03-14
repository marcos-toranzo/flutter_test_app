import 'package:flutter/material.dart';
import 'package:flutter_test_app/app_configuration.dart';
import 'package:flutter_test_app/controllers/cart_controller.dart';
import 'package:flutter_test_app/services/routing_service/routing_service.dart';
import 'package:flutter_test_app/utils/iterable_utils.dart';
import 'package:flutter_test_app/utils/localization.dart';
import 'package:flutter_test_app/utils/notifications.dart';
import 'package:flutter_test_app/views/cart/cart_checkout_fab.dart';
import 'package:flutter_test_app/views/cart/cart_entry_widget/cart_entry_widget.dart';
import 'package:flutter_test_app/views/cart/cart_screen_controller.dart';
import 'package:flutter_test_app/views/checkout/checkout_screen.dart';
import 'package:flutter_test_app/widgets/custom_appbar.dart';
import 'package:flutter_test_app/widgets/cutom_text.dart';
import 'package:flutter_test_app/widgets/page_with_loader.dart';
import 'package:flutter_test_app/widgets/screen_with_loader.dart';
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
      () => ScreenWithLoader(
        isLoading: controller.isLoading,
        appBar: CustomAppBar(
          titleText: translations.cart,
          onRefresh: controller.onRefresh,
          showCartButton: false,
        ),
        floatingActionButton: _cartController.totalCount > 0
            ? CartCheckoutFAB(
                controller: controller,
                onPressed: () {
                  routingService.pushRoute(
                    context: context,
                    routeName: CheckoutScreen.routeName,
                    routeArguments: RouteArguments(
                      transition: ScreenTransitions.slide,
                      toPay: controller.total,
                    ),
                  );
                },
              )
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: controller.cartBooksEntries.isNotEmpty
            ? ListView(
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
              )
            : Center(child: OnBackgroundText(translations.cartIsEmpty)),
      ),
    );
  }
}
