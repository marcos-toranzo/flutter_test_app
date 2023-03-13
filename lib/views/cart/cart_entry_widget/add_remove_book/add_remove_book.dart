import 'package:flutter/material.dart';
import 'package:flutter_test_app/utils/localization.dart';
import 'package:flutter_test_app/views/cart/cart_entry_widget/add_remove_book/book_counter.dart';
import 'package:flutter_test_app/widgets/buttons/custom_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddRemoveBook extends StatelessWidget {
  final int count;
  final VoidCallback onMinusPressed;
  final VoidCallback onPlusPressed;
  final VoidCallback onRemovePressed;

  const AddRemoveBook({
    required this.count,
    required this.onMinusPressed,
    required this.onPlusPressed,
    required this.onRemovePressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final translations = AppTranslations.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BookCounter(
          onMinusPressed: onMinusPressed,
          onPlusPressed: onPlusPressed,
          count: count,
        ),
        CustomButton(
          onPressed: onRemovePressed,
          text: translations.remove,
          iconData: FontAwesomeIcons.solidTrashCan,
        ),
      ],
    );
  }
}
