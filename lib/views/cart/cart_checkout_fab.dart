import 'package:flutter/material.dart';
import 'package:flutter_test_app/utils/localization.dart';
import 'package:flutter_test_app/views/cart/cart_screen_controller.dart';
import 'package:flutter_test_app/widgets/book/book_price_tag.dart';
import 'package:flutter_test_app/widgets/buttons/wide_button.dart';
import 'package:flutter_test_app/widgets/cutom_text.dart';

class CartCheckoutFAB extends StatelessWidget {
  final CartScreenController controller;
  final VoidCallback onPressed;
  final bool enabled;

  const CartCheckoutFAB({
    required this.controller,
    required this.onPressed,
    this.enabled = true,
    super.key,
  });

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
                OnBackgroundText(
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
              enabled: enabled,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              text: translations.checkout,
              onPressed: onPressed,
            ),
          ),
        ],
      ),
    );
  }
}
