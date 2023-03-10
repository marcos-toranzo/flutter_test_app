import 'package:flutter/material.dart';
import 'package:flutter_test_app/app_configuration.dart';
import 'package:flutter_test_app/utils/notifications.dart';
import 'package:flutter_test_app/views/home/home_screen.dart';
import 'package:flutter_test_app/views/login/login_controller.dart';
import 'package:flutter_test_app/widgets/email_icon.dart';
import 'package:flutter_test_app/widgets/password_icon.dart';
import 'package:flutter_test_app/widgets/wide_button.dart';
import 'package:get/get.dart';
import 'package:flutter_test_app/controllers/auth_controller.dart';
import 'package:flutter_test_app/utils/localization.dart';
import 'package:flutter_test_app/widgets/custom_text_form_field.dart';
import 'package:flutter_test_app/widgets/double_dismiss_screen.dart';
import 'package:flutter_test_app/widgets/page_with_loader.dart';
import 'package:flutter_test_app/widgets/app_logo.dart';
import 'package:flutter_test_app/widgets/space.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';

  final AuthController _authController = Get.find();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController(_authController));
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
                        CustomTextFormField(
                          hintText: translations.email,
                          controller: controller.emailController,
                          textInputAction: TextInputAction.next,
                          icon: const EmailIcon(),
                          position: TextFormFieldPosition.top,
                        ),
                        CustomTextFormField(
                          hintText: translations.password,
                          controller: controller.passwordController,
                          icon: const PasswordIcon(),
                          position: TextFormFieldPosition.bottom,
                        ),
                        const Space.vertical(10),
                        TextButton(
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
                      ],
                    ),
                    Column(
                      children: [
                        WideButton(
                          text: translations.toLogin,
                          onPressed: () {
                            controller.onLoginPressed(
                              onErrorLogingIn: () {
                                showSnackBar(
                                  context: context,
                                  text: translations.errorLogingIn,
                                );
                              },
                              onSuccessfulLogin: () {
                                routingService.popAndPushRoute(
                                  context: context,
                                  routeName: HomeScreen.routeName,
                                );
                              },
                            );
                          },
                        ),
                        const Space.vertical(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              translations.dontHaveAnAccount,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF8C8C8C),
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0,
                              ),
                            ),
                            TextButton(
                              // TODO: go to register screen
                              onPressed: () {},
                              child: Text(
                                translations.signUp,
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
