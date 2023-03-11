import 'package:flutter/material.dart';
import 'package:flutter_test_app/controllers/auth_controller.dart';
import 'package:flutter_test_app/utils/localization.dart';
import 'package:flutter_test_app/widgets/custom_appbar.dart';
import 'package:flutter_test_app/widgets/custom_drawer.dart';
import 'package:flutter_test_app/widgets/double_dismiss_screen.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';

  final AuthController _authController = Get.find();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final translations = AppTranslations.of(context);

    return DoubleDismissScreen(
      child: Scaffold(
        appBar: CustomAppBar(
          titleText: translations.home,
          cart: _authController.user!.cart,
          onCartPressed: () {},
        ),
        drawer: CustomDrawer(),
      ),
    );
  }
}
