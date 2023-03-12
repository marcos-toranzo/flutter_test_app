import 'package:flutter/material.dart';
import 'package:flutter_test_app/models/cart.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;
  final List<Widget>? actions;
  final VoidCallback? onRefresh;
  final Cart? cart;
  final VoidCallback? onCartPressed;

  const CustomAppBar({
    required this.titleText,
    this.cart,
    this.onCartPressed,
    this.actions,
    this.onRefresh,
    super.key,
  }) : assert(cart == null || onCartPressed != null);

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  Widget _buildCartButton(BuildContext context) {
    final booksCount = cart!.books.length;

    return IconButton(
      onPressed: onCartPressed,
      icon: Stack(
        alignment: Alignment.center,
        children: [
          const Icon(
            FontAwesomeIcons.cartShopping,
            size: 22,
          ),
          if (booksCount > 0)
            Padding(
              padding: const EdgeInsets.only(left: 18.0, bottom: 18.0),
              child: Container(
                width: 15 + (booksCount > 9 ? 5 : 0),
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
                      booksCount < 10 ? booksCount.toString() : '9+',
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
        if (cart != null) _buildCartButton(context),
      ],
    );
  }
}
