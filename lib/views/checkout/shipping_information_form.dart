import 'package:flutter/material.dart';
import 'package:flutter_test_app/utils/localization.dart';
import 'package:flutter_test_app/utils/validators.dart';
import 'package:flutter_test_app/views/checkout/form_header_text.dart';
import 'package:flutter_test_app/views/checkout/form_title_text.dart';
import 'package:flutter_test_app/widgets/form_fields/custom_form.dart';
import 'package:flutter_test_app/widgets/form_fields/custom_text_form_field.dart';
import 'package:flutter_test_app/widgets/space.dart';

class ShippingInformationForm extends StatelessWidget {
  final String? userEmail;
  final TextEditingController nameController;
  final TextEditingController addressController;
  final TextEditingController countryController;
  final TextEditingController cityController;
  final TextEditingController zipCodeController;
  final AutovalidateMode? autovalidateMode;
  final GlobalKey<FormState>? formKey;

  const ShippingInformationForm({
    required this.userEmail,
    required this.nameController,
    required this.addressController,
    required this.countryController,
    required this.cityController,
    required this.zipCodeController,
    this.autovalidateMode,
    this.formKey,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final translations = AppTranslations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormHeaderText(translations.shippingInformation),
        FormTitleText(translations.email),
        CustomTextFormField(
          value: userEmail ?? '',
          readOnly: true,
          visualDensity: VisualDensity.compact,
        ),
        const Space.vertical(10),
        FormTitleText(translations.shippingAddress),
        CustomForm(
          formKey: formKey,
          fields: [
            CustomTextFormField(
              controller: nameController,
              hintText: translations.name,
              position: TextFormFieldPosition.top,
              visualDensity: VisualDensity.compact,
              autovalidateMode: autovalidateMode,
              validators: [
                FormFieldValidators.required(translations.required),
              ],
            ),
            CustomTextFormField(
              controller: addressController,
              hintText: translations.addressLine,
              position: TextFormFieldPosition.center,
              visualDensity: VisualDensity.compact,
              autovalidateMode: autovalidateMode,
              validators: [
                FormFieldValidators.required(translations.required),
              ],
            ),
            CustomTextFormField(
              controller: countryController,
              hintText: translations.country,
              position: TextFormFieldPosition.center,
              visualDensity: VisualDensity.compact,
              autovalidateMode: autovalidateMode,
              validators: [
                FormFieldValidators.required(translations.required),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CustomTextFormField(
                    controller: cityController,
                    hintText: translations.city,
                    position: TextFormFieldPosition.bottomLeft,
                    visualDensity: VisualDensity.compact,
                    autovalidateMode: autovalidateMode,
                    validators: [
                      FormFieldValidators.required(translations.required),
                    ],
                  ),
                ),
                Expanded(
                  child: CustomTextFormField(
                    controller: zipCodeController,
                    hintText: translations.zipCode,
                    position: TextFormFieldPosition.bottomRight,
                    textInputType: TextInputType.number,
                    inputFormatters: [FormFieldFormatters.numbersOnly()],
                    visualDensity: VisualDensity.compact,
                    autovalidateMode: autovalidateMode,
                    validators: [
                      FormFieldValidators.required(translations.required),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
