import 'package:flutter/material.dart';
import 'package:flutter_test_app/widgets/ink_well_button.dart';
import 'package:flutter_test_app/widgets/row_with_padding.dart';
import 'package:flutter_test_app/widgets/space.dart';

class CustomButton extends StatelessWidget {
  final BorderRadius? borderRadius;
  final VoidCallback onPressed;
  final String text;
  final IconData? iconData;

  const CustomButton({
    required this.onPressed,
    required this.text,
    this.borderRadius,
    this.iconData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWellButton(
      onTap: onPressed,
      borderRadius: borderRadius,
      child: RowWithPadding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        children: [
          Text(
            text,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (iconData != null) ...[
            const Space.horizontal(5),
            Icon(iconData, size: 10, color: Theme.of(context).primaryColor),
          ]
        ],
      ),
    );
  }
}
