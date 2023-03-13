import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test_app/utils/styling.dart';
import 'package:flutter_test_app/utils/validators.dart';

enum TextFormFieldPosition {
  only,
  top,
  topLeft,
  topRight,
  center,
  bottom,
  bottomLeft,
  bottomRight,
}

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final String? hintText;
  final Widget? icon;
  final TextFormFieldPosition position;
  final TextInputType? textInputType;
  final bool obscureText;
  final List<FormFieldValidator<String>> validators;
  final AutovalidateMode? autovalidateMode;
  final bool readOnly;
  final String? value;
  final List<TextInputFormatter>? inputFormatters;
  final VisualDensity visualDensity;

  const CustomTextFormField({
    this.hintText,
    this.controller,
    this.value,
    this.position = TextFormFieldPosition.only,
    this.textInputType,
    this.validators = const [],
    this.textInputAction,
    this.autovalidateMode,
    this.obscureText = false,
    this.readOnly = false,
    this.icon,
    this.inputFormatters,
    this.visualDensity = VisualDensity.standard,
    super.key,
  }) : assert(controller != null || value != null);

  @override
  Widget build(BuildContext context) {
    const borderRadius = Radius.circular(borderRadiusValue);

    final isOnly = position == TextFormFieldPosition.only;
    final isBottom = position == TextFormFieldPosition.bottom || isOnly;
    final isBottomLeft =
        position == TextFormFieldPosition.bottomLeft || isBottom;
    final isBottomRight =
        position == TextFormFieldPosition.bottomRight || isBottom;
    final isTop = position == TextFormFieldPosition.top || isOnly;
    final isTopLeft = position == TextFormFieldPosition.topLeft || isTop;
    final isTopRight = position == TextFormFieldPosition.topRight || isTop;

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.only(
        topLeft: isTopLeft ? borderRadius : Radius.zero,
        topRight: isTopRight ? borderRadius : Radius.zero,
        bottomLeft: isBottomLeft ? borderRadius : Radius.zero,
        bottomRight: isBottomRight ? borderRadius : Radius.zero,
      ),
      borderSide: const BorderSide(
        color: Color(0xFFD2D2D2),
        width: 0.8,
      ),
    );

    final inputAction = textInputAction ??
        (isBottomRight ? TextInputAction.done : TextInputAction.next);

    return TextFormField(
      inputFormatters: inputFormatters,
      readOnly: readOnly,
      initialValue: value,
      controller: controller,
      textInputAction: inputAction,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.onBackground,
      ),
      keyboardType: textInputType,
      obscureText: obscureText,
      validator: FormFieldValidators.chain(validators),
      autovalidateMode: autovalidateMode,
      decoration: InputDecoration(
        prefixIcon: icon != null
            ? Padding(
                padding: const EdgeInsets.only(right: 18.0, left: 24.0),
                child: icon,
              )
            : null,
        hintText: hintText,
        enabledBorder: border,
        focusedBorder: border.copyWith(
          borderSide: border.borderSide.copyWith(
            color: Theme.of(context).primaryColor,
          ),
        ),
        contentPadding: visualDensity == VisualDensity.compact
            ? const EdgeInsets.all(10)
            : null,
        errorBorder: border,
        border: border,
      ),
    );
  }
}
