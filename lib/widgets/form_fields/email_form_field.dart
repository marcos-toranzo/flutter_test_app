import 'package:flutter/material.dart';
import 'package:flutter_test_app/utils/localization.dart';
import 'package:flutter_test_app/utils/validators.dart';
import 'package:flutter_test_app/widgets/form_fields/custom_text_form_field.dart';
import 'package:flutter_test_app/widgets/icons/email_icon.dart';

class EmailFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextFormFieldPosition position;
  final TextInputAction? textInputAction;
  final bool isRequired;
  final List<FormFieldValidator<String>> extraValidators;

  const EmailFormField({
    required this.controller,
    required this.position,
    this.extraValidators = const [],
    this.textInputAction,
    this.isRequired = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final translations = AppTranslations.of(context);

    return CustomTextFormField(
      hintText: translations.email,
      controller: controller,
      icon: const EmailIcon(),
      position: position,
      textInputAction: textInputAction,
      validators: [
        if (isRequired) FormValidators.required(translations.required),
        FormValidators.email(translations.invalidEmail),
        ...extraValidators,
      ],
    );
  }
}
