import 'package:flutter/material.dart';
import 'package:flutter_test_app/utils/localization.dart';
import 'package:flutter_test_app/utils/validators.dart';
import 'package:flutter_test_app/views/login_signup/login_signup_form/email_form_field.dart';
import 'package:flutter_test_app/views/login_signup/login_signup_form/password_form_field.dart';
import 'package:flutter_test_app/widgets/form_fields/custom_form.dart';
import 'package:flutter_test_app/widgets/form_fields/custom_text_form_field.dart';

class LoginSignUpForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController repeatPasswordController;
  final bool isLogingIn;
  final AutovalidateMode? autovalidateMode;

  const LoginSignUpForm({
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.repeatPasswordController,
    required this.isLogingIn,
    this.autovalidateMode,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final translations = AppTranslations.of(context);

    return Column(
      children: [
        CustomForm(
          formKey: formKey,
          fields: [
            EmailFormField(
              controller: emailController,
              position: TextFormFieldPosition.top,
              autovalidateMode: autovalidateMode,
            ),
            PasswordFormField(
              controller: passwordController,
              position: isLogingIn
                  ? TextFormFieldPosition.bottom
                  : TextFormFieldPosition.center,
              autovalidateMode: autovalidateMode,
              checks: isLogingIn
                  ? []
                  : [
                      PasswordValidator.minLength(
                        count: 8,
                        errorMessage: translations.atLeastNCharacters(8),
                      ),
                      PasswordValidator.lowercaseCount(
                        count: 1,
                        errorMessage: translations.atLeastNLowercase(1),
                      ),
                      PasswordValidator.uppercaseCount(
                        count: 1,
                        errorMessage: translations.atLeastNUppercase(1),
                      ),
                      PasswordValidator.numericCount(
                        count: 1,
                        errorMessage: translations.atLeastNNumeric(1),
                      ),
                      PasswordValidator.specialCount(
                        count: 1,
                        errorMessage: translations.atLeastNSpecial(1),
                      ),
                    ],
            ),
            if (!isLogingIn)
              PasswordFormField(
                hintText: translations.repeatPassword,
                controller: repeatPasswordController,
                position: TextFormFieldPosition.bottom,
                autovalidateMode: autovalidateMode,
                extraValidators: [
                  (value) => value != passwordController.text
                      ? translations.passwordsDontMatch
                      : null,
                ],
              ),
          ],
        ),
        if (isLogingIn)
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: TextButton(
              // TODO: go to Forgot your password flow.
              // NOT IN THE SCOPE OF THE TEST
              onPressed: () {},
              child: Text(
                translations.forgotYourPassowrd,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF8C8C8C),
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
