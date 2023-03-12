import 'package:flutter/material.dart';
import 'package:flutter_test_app/utils/localization.dart';
import 'package:flutter_test_app/views/cart/cart_screen_controller.dart';
import 'package:flutter_test_app/widgets/custom_appbar.dart';
import 'package:flutter_test_app/widgets/page_with_loader.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = '/cart';

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartScreenController());
    final translations = AppTranslations.of(context);

    return Obx(
      () {
        return PageWithLoader(
          loaderText: translations.loading,
          showLoader: controller.isLoading,
          child: Scaffold(
            appBar: CustomAppBar(
              titleText: translations.cart,
              onRefresh: controller.onRefresh,
            ),
          ),
        );
      },
    );
  }
}
