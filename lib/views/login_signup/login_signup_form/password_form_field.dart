import 'package:flutter/material.dart';
import 'package:flutter_test_app/utils/localization.dart';
import 'package:flutter_test_app/utils/validators.dart';
import 'package:flutter_test_app/widgets/custom_icon.dart';
import 'package:flutter_test_app/widgets/form_fields/custom_text_form_field.dart';

class PasswordFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextFormFieldPosition position;
  final AutovalidateMode? autovalidateMode;
  final String? hintText;
  final List<PasswordValidator> checks;
  final List<FormFieldValidator<String>> extraValidators;

  const PasswordFormField({
    required this.controller,
    this.position = TextFormFieldPosition.only,
    this.extraValidators = const [],
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
      icon: CustomIcon.password(),
      autovalidateMode: autovalidateMode,
      position: position,
      obscureText: true,
      validators: [
        FormFieldValidators.required(translations.required),
        FormFieldValidators.password(checks),
        ...extraValidators,
      ],
    );
  }
}
