import 'package:flutter/material.dart';
import 'package:flutter_test_app/views/cart/cart_entry_widget/add_remove_book/counter_button.dart';
import 'package:flutter_test_app/widgets/cutom_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BookCounter extends StatelessWidget {
  final VoidCallback onMinusPressed;
  final VoidCallback onPlusPressed;
  final bool isEditingCount;
  final int count;

  const BookCounter({
    required this.onMinusPressed,
    required this.onPlusPressed,
    required this.count,
    this.isEditingCount = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CounterButton(
          onTap: onMinusPressed,
          iconData: FontAwesomeIcons.chevronLeft,
          enabled: count > 1 && !isEditingCount,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: OnBackgroundText(count.toString()),
        ),
        CounterButton(
          onTap: onPlusPressed,
          iconData: FontAwesomeIcons.chevronRight,
          enabled: !isEditingCount,
        ),
      ],
    );
  }
}
