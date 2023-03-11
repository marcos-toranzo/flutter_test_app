import 'package:flutter/material.dart';
import 'package:flutter_test_app/utils/styling.dart';
import 'package:flutter_test_app/utils/validators.dart';

enum TextFormFieldPosition {
  only,
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
  final TextInputType? textInputType;
  final bool obscureText;
  final List<FormFieldValidator<String>> validators;
  final AutovalidateMode? autovalidateMode;

  const CustomTextFormField({
    required this.controller,
    required this.hintText,
    this.position = TextFormFieldPosition.only,
    this.textInputType,
    this.validators = const [],
    this.textInputAction,
    this.autovalidateMode,
    this.obscureText = false,
    this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const borderRadius = Radius.circular(borderRadiusValue);

    final isBottom = position == TextFormFieldPosition.bottom ||
        position == TextFormFieldPosition.only;
    final isTop = position == TextFormFieldPosition.top ||
        position == TextFormFieldPosition.only;

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

    final inputAction = textInputAction ??
        (isBottom ? TextInputAction.done : TextInputAction.next);

    return TextFormField(
      controller: controller,
      textInputAction: inputAction,
      style: const TextStyle(fontWeight: FontWeight.w600),
      keyboardType: textInputType,
      obscureText: obscureText,
      validator: FormValidators.compose(validators),
      autovalidateMode: autovalidateMode,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFFAFAFA),
        prefixIcon: icon != null
            ? Padding(
                padding: const EdgeInsets.only(right: 18.0, left: 24.0),
                child: icon,
              )
            : null,
        hintText: hintText,
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Color(0xFF8C8C8C),
        ),
        enabledBorder: border,
        focusedBorder: border.copyWith(
          borderSide: border.borderSide.copyWith(
            color: Theme.of(context).primaryColor,
          ),
        ),
        errorBorder: border,
        border: border,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 25,
        ),
      ),
    );
  }
}
