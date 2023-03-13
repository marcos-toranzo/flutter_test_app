import 'package:flutter/material.dart';
import 'package:flutter_test_app/utils/localization.dart';
import 'package:flutter_test_app/utils/validators.dart';
import 'package:flutter_test_app/views/checkout/payment_info_form/card_cvv_form_field.dart';
import 'package:flutter_test_app/views/checkout/payment_info_form/card_expiration_date_form_field.dart';
import 'package:flutter_test_app/views/checkout/payment_info_form/card_number_form_field.dart';
import 'package:flutter_test_app/views/checkout/form_header_text.dart';
import 'package:flutter_test_app/views/checkout/form_title_text.dart';
import 'package:flutter_test_app/widgets/form_fields/custom_form.dart';
import 'package:flutter_test_app/widgets/form_fields/custom_text_form_field.dart';

class PaymentInfoForm extends StatelessWidget {
  final TextEditingController cardNumberController;
  final TextEditingController cardHolderNameController;
  final TextEditingController cardExpDateController;
  final TextEditingController cardCVCController;
  final AutovalidateMode? autovalidateMode;
  final GlobalKey<FormState>? formKey;

  const PaymentInfoForm({
    required this.cardNumberController,
    required this.cardHolderNameController,
    required this.cardExpDateController,
    required this.cardCVCController,
    this.formKey,
    this.autovalidateMode,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final translations = AppTranslations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormHeaderText(translations.paymentDetails),
        FormTitleText(translations.cardInformation),
        CustomForm(
          formKey: formKey,
          fields: [
            CardNumberFormField(
              controller: cardNumberController,
              autovalidateMode: autovalidateMode,
              position: TextFormFieldPosition.top,
            ),
            CustomTextFormField(
              controller: cardHolderNameController,
              hintText: translations.cardHolderName,
              position: TextFormFieldPosition.center,
              autovalidateMode: autovalidateMode,
              visualDensity: VisualDensity.compact,
              validators: [
                FormFieldValidators.required(translations.required),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: CardExpirationDateFormField(
                    controller: cardExpDateController,
                    autovalidateMode: autovalidateMode,
                    position: TextFormFieldPosition.bottomLeft,
                  ),
                ),
                Expanded(
                  child: CardCvcFormField(
                    controller: cardCVCController,
                    autovalidateMode: autovalidateMode,
                    position: TextFormFieldPosition.bottomRight,
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
