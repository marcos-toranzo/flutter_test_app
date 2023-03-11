import 'package:flutter/material.dart';
import 'package:flutter_test_app/app_configuration.dart';
import 'package:flutter_test_app/utils/notifications.dart';
import 'package:flutter_test_app/utils/validators.dart';
import 'package:flutter_test_app/views/home/home_screen.dart';
import 'package:flutter_test_app/views/login_signup/login_signup_controller.dart';
import 'package:flutter_test_app/widgets/form_fields/custom_form.dart';
import 'package:flutter_test_app/widgets/form_fields/email_form_field.dart';
import 'package:flutter_test_app/widgets/form_fields/password_form_field.dart';
import 'package:flutter_test_app/widgets/wide_button.dart';
import 'package:get/get.dart';
import 'package:flutter_test_app/controllers/auth_controller.dart';
import 'package:flutter_test_app/utils/localization.dart';
import 'package:flutter_test_app/widgets/form_fields/custom_text_form_field.dart';
import 'package:flutter_test_app/widgets/double_dismiss_screen.dart';
import 'package:flutter_test_app/widgets/page_with_loader.dart';
import 'package:flutter_test_app/widgets/app_logo.dart';
import 'package:flutter_test_app/widgets/space.dart';

class LoginSignUpScreen extends StatelessWidget {
  static const routeName = '/login_signup';

  final AuthController _authController = Get.find();

  final _formKey = GlobalKey<FormState>();

  LoginSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginSignUpController(_authController));
    final translations = AppTranslations.of(context);

    const verticalPadding = 100.0;

    return DoubleDismissScreen(
      child: Obx(
        () => PageWithLoader(
          showLoader: controller.isLoading,
          loaderText: translations.logingIn,
          child: Scaffold(
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: verticalPadding,
              ),
              child: SizedBox(
                height:
                    MediaQuery.of(context).size.height - verticalPadding * 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const AppLogo(size: 110, includeText: false),
                        const Space.vertical(80),
                        CustomForm(
                          formKey: _formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          fields: [
                            EmailFormField(
                              controller: controller.emailController,
                              position: TextFormFieldPosition.top,
                              isRequired: true,
                            ),
                            PasswordFormField(
                              controller: controller.passwordController,
                              position: controller.isLogingIn
                                  ? TextFormFieldPosition.bottom
                                  : TextFormFieldPosition.middle,
                              isRequired: true,
                              checks: PasswordValidationChecks(
                                minLengthCheck: PasswordValidationCheck(
                                  count: 8,
                                  errorMessage: translations
                                      .passwordAtLeastNCharacters(8),
                                ),
                                numericCharCountCheck: PasswordValidationCheck(
                                  count: 1,
                                  errorMessage: translations
                                      .passwordAtLeastNNumericCharacters(1),
                                ),
                                specialCharCountCheck: PasswordValidationCheck(
                                  count: 1,
                                  errorMessage: translations
                                      .passwordAtLeastNSpecialCharacters(1),
                                ),
                                uppercaseCharCountCheck:
                                    PasswordValidationCheck(
                                  count: 1,
                                  errorMessage: translations
                                      .passwordAtLeastNUppercaseCharacters(1),
                                ),
                              ),
                            ),
                            if (!controller.isLogingIn)
                              PasswordFormField(
                                hintText: translations.repeatPassword,
                                controller: controller.repeatPasswordController,
                                position: TextFormFieldPosition.bottom,
                                isRequired: true,
                                extraValidators: [
                                  (value) => value !=
                                          controller.passwordController.text
                                      ? translations.passwordsDontMatch
                                      : null,
                                ],
                              ),
                          ],
                        ),
                        if (controller.isLogingIn)
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: TextButton(
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
                    ),
                    Column(
                      children: [
                        WideButton(
                          text: controller.isLogingIn
                              ? translations.toLogin
                              : translations.toSignUp,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (controller.isLogingIn) {
                                controller.onLoginPressed(
                                  onError: () {
                                    showSnackBar(
                                      context: context,
                                      text: translations.errorLogingIn,
                                    );
                                  },
                                  onSuccess: () {
                                    routingService.popAndPushRoute(
                                      context: context,
                                      routeName: HomeScreen.routeName,
                                    );
                                  },
                                );
                              } else {
                                controller.onSignUpPressed(
                                  onError: () {
                                    showSnackBar(
                                      context: context,
                                      text: translations.errorSigningUp,
                                    );
                                  },
                                  onSuccess: () {
                                    routingService.popAndPushRoute(
                                      context: context,
                                      routeName: HomeScreen.routeName,
                                    );
                                  },
                                );
                              }
                            } else {}
                          },
                        ),
                        const Space.vertical(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              controller.isLogingIn
                                  ? translations.dontHaveAnAccount
                                  : translations.alreadyHaveAnAccount,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF8C8C8C),
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0,
                              ),
                            ),
                            TextButton(
                              onPressed: controller.changeMode,
                              child: Text(
                                controller.isLogingIn
                                    ? translations.signUp
                                    : translations.login,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
