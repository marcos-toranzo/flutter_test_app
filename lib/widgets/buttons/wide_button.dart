import 'package:flutter/material.dart';
import 'package:flutter_test_app/utils/styling.dart';
import 'package:flutter_test_app/widgets/buttons/ink_well_button.dart';

class WideButton extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final String text;
  final IconData? iconData;
  final VoidCallback onPressed;

  const WideButton({
    super.key,
    this.padding,
    this.iconData,
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
          elevation: 10,
          borderRadius: BorderRadius.circular(borderRadiusValue),
          onTap: onPressed,
          backgroundColor: Theme.of(context).primaryColor,
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
