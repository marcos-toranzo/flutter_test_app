import 'package:flutter/material.dart';
import 'package:flutter_test_app/utils/localization.dart';
import 'package:flutter_test_app/utils/validators.dart';
import 'package:flutter_test_app/widgets/custom_icon.dart';
import 'package:flutter_test_app/widgets/form_fields/custom_text_form_field.dart';

class EmailFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextFormFieldPosition position;
  final AutovalidateMode? autovalidateMode;

  const EmailFormField({
    required this.controller,
    this.position = TextFormFieldPosition.only,
    this.autovalidateMode,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final translations = AppTranslations.of(context);

    return CustomTextFormField(
      hintText: translations.email,
      controller: controller,
      icon: CustomIcon.email(),
      position: position,
      autovalidateMode: autovalidateMode,
      validators: [
        FormFieldValidators.required(translations.required),
        FormFieldValidators.email(translations.invalidEmail),
      ],
    );
  }
}
