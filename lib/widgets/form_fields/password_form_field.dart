import 'package:flutter/material.dart';
import 'package:flutter_test_app/utils/localization.dart';
import 'package:flutter_test_app/utils/validators.dart';
import 'package:flutter_test_app/widgets/form_fields/custom_text_form_field.dart';
import 'package:flutter_test_app/widgets/icons/password_icon.dart';

class PasswordFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextFormFieldPosition position;
  final TextInputAction? textInputAction;
  final AutovalidateMode? autovalidateMode;
  final String? hintText;
  final bool isRequired;
  final bool obscureText;
  final List<PasswordValidator> checks;
  final List<FormFieldValidator<String>> extraValidators;

  const PasswordFormField({
    required this.controller,
    required this.position,
    this.obscureText = true,
    this.isRequired = false,
    this.extraValidators = const [],
    this.textInputAction,
    this.autovalidateMode,
    this.checks = const [],
    this.hintText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final translations = AppTranslations.of(context);

    return CustomTextFormField(
      hintText: hintText ?? translations.password,
      controller: controller,
      icon: const PasswordIcon(),
      obscureText: obscureText,
      position: position,
      textInputAction: textInputAction,
      validators: [
        if (isRequired) FormValidators.required(translations.required),
        FormValidators.password(checks),
        ...extraValidators,
      ],
    );
  }
}
