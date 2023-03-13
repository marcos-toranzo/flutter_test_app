import 'package:flutter/material.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:flutter_test_app/controllers/cart_controller.dart';
import 'package:flutter_test_app/views/home/home_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_test_app/app_configuration.dart';
import 'package:flutter_test_app/controllers/app_configuration_controller.dart';
import 'package:flutter_test_app/controllers/auth_controller.dart';
import 'package:flutter_test_app/utils/localization.dart';
import 'package:flutter_test_app/utils/styling.dart';
import 'package:flutter_test_app/views/login_signup/login_signup_screen.dart';
import 'package:flutter_test_app/widgets/app_logo.dart';
import 'package:flutter_test_app/widgets/space.dart';

void main() async {
  await initConfig();
  runApp(FlutterTestApp());
}

class FlutterTestApp extends StatelessWidget {
  late final AppConfigurationController _appConfigurationController;

  FlutterTestApp({super.key}) {
    Get.put(AuthController());
    Get.put(CartController());
    _appConfigurationController =
        Get.put(AppConfigurationController(Localization.supportedLocales));
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        localizationsDelegates: [
          const LocaleNamesLocalizationsDelegate(),
          ...Localization.localizationsDelegates,
        ],
        supportedLocales: Localization.supportedLocales,
        locale: _appConfigurationController.selectedLocale,
        title: 'Flutter Test App',
        theme: lightAppTheme,
        debugShowCheckedModeBanner: false,
        themeMode: _appConfigurationController.appThemeMode,
        darkTheme: darkAppTheme,
        onGenerateRoute: routingService.onGenerateRoute,
        home: const _InitialScreen(),
      ),
    );
  }
}

class _InitialScreen extends StatefulWidget {
  const _InitialScreen();

  @override
  State<_InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<_InitialScreen> {
  final AuthController _authController = Get.find();
  final CartController _cartController = Get.find();

  @override
  void initState() {
    super.initState();
    _authController.checkLoggedInSession(
      onSuccess: onLoginSuccess,
      onError: onError,
    );
  }

  Future<void> onLoginSuccess() async {
    _cartController.fetchCart(
      id: _authController.user!.cartId,
      onError: onError,
      onSuccess: () {
        routingService.popAndPushRoute(
          context: context,
          routeName: HomeScreen.routeName,
        );
      },
    );
  }

  void onError() {
    routingService.popAndPushRoute(
      context: context,
      routeName: LoginSignUpScreen.routeName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            AppLogo(size: 160),
            Space.vertical(50),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
