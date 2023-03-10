import 'package:flutter/material.dart';
import 'package:flutter_test_app/utils/styling.dart';

enum TextFormFieldPosition {
  top,
  middle,
  bottom,
}

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputAction? textInputAction;
  final String hintText;
  final Widget? icon;
  final TextFormFieldPosition position;

  const CustomTextFormField({
    required this.controller,
    required this.hintText,
    this.position = TextFormFieldPosition.middle,
    this.textInputAction,
    this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const borderRadius = Radius.circular(borderRadiusValue);

    final isBottom = position == TextFormFieldPosition.bottom;
    final isTop = position == TextFormFieldPosition.top;

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.only(
        topLeft: isTop ? borderRadius : Radius.zero,
        topRight: isTop ? borderRadius : Radius.zero,
        bottomLeft: isBottom ? borderRadius : Radius.zero,
        bottomRight: isBottom ? borderRadius : Radius.zero,
      ),
      borderSide: const BorderSide(
        color: Color(0xFFD2D2D2),
        width: 0.8,
      ),
    );

    return TextFormField(
      controller: controller,
      textInputAction: textInputAction,
      style: const TextStyle(fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFFAFAFA),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(right: 18.0, left: 24.0),
          child: icon,
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Color(0xFF8C8C8C),
        ),
        enabledBorder: border,
        focusedBorder: border,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 25,
        ),
      ),
    );
  }
}
