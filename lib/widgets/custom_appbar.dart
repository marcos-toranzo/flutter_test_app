import 'package:flutter/material.dart';
import 'package:flutter_test_app/controllers/cart_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;
  final List<Widget>? actions;
  final VoidCallback? onRefresh;

  final CartController _cartController = Get.find();

  CustomAppBar({
    required this.titleText,
    this.actions,
    this.onRefresh,
    super.key,
  });

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  Widget _buildCartButton(BuildContext context) {
    final total = _cartController.cart?.total;

    if (total == null) return const Placeholder();

    return IconButton(
      // TODO: go to cart screen
      onPressed: () {},
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
    return AppBar(
      title: Text(titleText),
      actions: [
        if (actions != null) ...actions!,
        if (onRefresh != null)
          IconButton(
            onPressed: onRefresh,
            icon: const Icon(FontAwesomeIcons.arrowsRotate),
          ),
        Obx(() => _buildCartButton(context)),
      ],
    );
  }
}
