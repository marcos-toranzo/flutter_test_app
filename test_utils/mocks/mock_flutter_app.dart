import 'package:flutter/material.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:flutter_test_app/app_configuration.dart';
import 'package:flutter_test_app/controllers/app_configuration_controller.dart';
import 'package:flutter_test_app/controllers/auth_controller.dart';
import 'package:flutter_test_app/controllers/cart_controller.dart';
import 'package:flutter_test_app/utils/localization.dart';
import 'package:get/get.dart';

import '../../test_utils/mocks/logged_user_mock_secure_storage_service.dart';
import '../../test_utils/mocks/mock_database_service.dart';
import '../../test_utils/mocks/mock_network_service.dart';
import '../../test_utils/mocks/mock_storage_service.dart';

Future<Widget> initAndGetMockFlutterApp(Widget child) async {
  networkService = MockNetworkService();
  databaseService = MockDatabaseService();
  secureStorageService = LoggedUserMockedSecureStorageService();
  storageService = MockStorageService();
  databaseService = MockDatabaseService();

  await initConfig();

  return MockFlutterApp(child: child);
}

class MockFlutterApp extends StatelessWidget {
  late final AppConfigurationController _appConfigurationController;
  final Widget child;

  MockFlutterApp({super.key, required this.child}) {
    final authController = Get.put(AuthController());
    final cartController = Get.put(CartController());
    _appConfigurationController = Get.put(
      AppConfigurationController(Localization.supportedLocales),
    );
    authController.checkLoggedInSession(onSuccess: () {
      cartController.fetchCart(id: authController.user!.cartId);
    });
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
        debugShowCheckedModeBanner: false,
        themeMode: _appConfigurationController.appThemeMode,
        onGenerateRoute: routingService.onGenerateRoute,
        home: child,
      ),
    );
  }
}
