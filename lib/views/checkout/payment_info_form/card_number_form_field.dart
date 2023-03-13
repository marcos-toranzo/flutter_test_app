import 'package:flutter/material.dart';
import 'package:flutter_test_app/utils/localization.dart';
import 'package:flutter_test_app/utils/validators.dart';
import 'package:flutter_test_app/widgets/form_fields/custom_text_form_field.dart';

class CardNumberFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextFormFieldPosition position;
  final AutovalidateMode? autovalidateMode;

  const CardNumberFormField({
    required this.controller,
    this.position = TextFormFieldPosition.only,
    this.autovalidateMode,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final translations = AppTranslations.of(context);

    return CustomTextFormField(
      controller: controller,
      hintText: '1234 1234 1234 1234',
      inputFormatters: [FormFieldFormatters.cardNumber()],
      textInputType: TextInputType.number,
      position: position,
      visualDensity: VisualDensity.compact,
      autovalidateMode: autovalidateMode,
      validators: [
        FormFieldValidators.required(translations.required),
        FormFieldValidators.exactLength(
          errorMessage: translations.invalidCardNumber,
          length: 4 * 4 + 3,
        ),
      ],
    );
  }
}
