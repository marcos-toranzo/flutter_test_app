import 'package:flutter/material.dart';
import 'package:flutter_test_app/utils/styling.dart';
import 'package:flutter_test_app/widgets/buttons/ink_well_button.dart';
import 'package:flutter_test_app/widgets/row_with_padding.dart';
import 'package:flutter_test_app/widgets/space.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final IconData? iconData;
  final bool enabled;

  const CustomButton({
    required this.onPressed,
    required this.text,
    this.iconData,
    this.enabled = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWellButton(
      transparent: false,
      onTap: enabled ? onPressed : () {},
      borderRadius: BorderRadius.circular(borderRadiusValue),
      child: RowWithPadding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        children: [
          Text(
            text,
            style: TextStyle(
              color: enabled
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).disabledColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (iconData != null) ...[
            const Space.horizontal(5),
            Icon(
              iconData,
              size: 10,
              color: enabled
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).disabledColor,
            ),
          ]
        ],
      ),
    );
  }
}
