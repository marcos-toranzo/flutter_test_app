import 'package:flutter/material.dart';
import 'package:flutter_test_app/views/home/home_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_test_app/app_configuration.dart';
import 'package:flutter_test_app/controllers/app_configuration_controller.dart';
import 'package:flutter_test_app/controllers/auth_controller.dart';
import 'package:flutter_test_app/utils/localization.dart';
import 'package:flutter_test_app/utils/styling.dart';
import 'package:flutter_test_app/views/login/login_screen.dart';
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
    _appConfigurationController =
        Get.put(AppConfigurationController(Localization.supportedLocales));
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        localizationsDelegates: Localization.localizationsDelegates,
        supportedLocales: Localization.supportedLocales,
        locale: _appConfigurationController.selectedLocale,
        title: 'Flutter Test App',
        theme: lightAppTheme,
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

  @override
  void initState() {
    super.initState();
    _authController.checkLoggedInSession(
      onSuccess: onLoginSuccess,
      onError: onLoginError,
    );
  }

  void onLoginSuccess() {
    routingService.popAndPushRoute(
      context: context,
      routeName: HomeScreen.routeName,
    );
  }

  void onLoginError() {
    routingService.popAndPushRoute(
      context: context,
      routeName: LoginScreen.routeName,
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
