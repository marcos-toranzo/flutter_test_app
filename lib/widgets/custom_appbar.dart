import 'package:flutter/material.dart';
import 'package:flutter_test_app/app_configuration.dart';
import 'package:flutter_test_app/controllers/cart_controller.dart';
import 'package:flutter_test_app/services/routing_service/routing_service.dart';
import 'package:flutter_test_app/views/cart/cart_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;
  final List<Widget>? actions;
  final VoidCallback? onRefresh;
  final bool showCartButton;
  final bool isRefreshing;

  final CartController _cartController = Get.find();

  CustomAppBar({
    required this.titleText,
    this.actions,
    this.showCartButton = true,
    this.onRefresh,
    this.isRefreshing = false,
    super.key,
  });

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  Widget _buildCartButton(BuildContext context) {
    final total = _cartController.totalCount;

    return IconButton(
      onPressed: () {
        routingService.pushRoute(
          context: context,
          routeName: CartScreen.routeName,
          routeArguments: RouteArguments(
            transition: ScreenTransitions.slide,
          ),
        );
      },
      icon: Stack(
        alignment: Alignment.center,
        children: [
          const Icon(
            FontAwesomeIcons.cartShopping,
            size: 22,
          ),
          if (total > 0)
            Padding(
              padding: const EdgeInsets.only(left: 18.0, bottom: 18.0),
              child: Container(
                width: 15 + (total > 9 ? 5 : 0),
                height: 15,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      total < 10 ? total.toString() : '9+',
                      style: TextStyle(
                        fontSize: 10,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppBar(
        title: Text(titleText),
        actions: [
          if (actions != null) ...actions!,
          if (isRefreshing)
            const Padding(
              padding: EdgeInsets.only(right: 12.0),
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(),
              ),
            ),
          if (!isRefreshing && onRefresh != null)
            IconButton(
              onPressed: onRefresh,
              icon: const Icon(FontAwesomeIcons.arrowsRotate),
            ),
          if (_cartController.cart != null && showCartButton)
            _buildCartButton(context),
        ],
      ),
    );
  }
}
