import 'package:flutter/material.dart';
import 'package:flutter_test_app/utils/styling.dart';
import 'package:flutter_test_app/widgets/buttons/ink_well_button.dart';

class WideButton extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final String text;
  final IconData? iconData;
  final VoidCallback onPressed;
  final bool enabled;
  final double elevation;

  const WideButton({
    super.key,
    this.padding,
    this.iconData,
    this.elevation = 10,
    this.enabled = true,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: InkWellButton(
          elevation: enabled ? elevation : 0,
          borderRadius: BorderRadius.circular(borderRadiusValue),
          onTap: enabled ? onPressed : () {},
          backgroundColor: enabled
              ? Theme.of(context).primaryColor
              : Theme.of(context).disabledColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (iconData != null)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Icon(
                    iconData,
                    color: Colors.white,
                    size: 18,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
