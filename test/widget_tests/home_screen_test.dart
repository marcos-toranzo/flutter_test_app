import 'package:flutter/material.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_app/app_configuration.dart';
import 'package:flutter_test_app/controllers/app_configuration_controller.dart';
import 'package:flutter_test_app/controllers/auth_controller.dart';
import 'package:flutter_test_app/controllers/cart_controller.dart';
import 'package:flutter_test_app/utils/localization.dart';
import 'package:flutter_test_app/views/home/book_category_preview.dart';
import 'package:flutter_test_app/views/home/home_screen.dart';
import 'package:flutter_test_app/widgets/custom_appbar.dart';
import 'package:flutter_test_app/widgets/custom_drawer.dart';
import 'package:flutter_test_app/widgets/screen_with_loader.dart';
import 'package:get/get.dart';

import '../../test_utils/mocks/data.dart';
import '../../test_utils/mocks/logged_user_mock_secure_storage_service.dart';
import '../../test_utils/mocks/mock_database_service.dart';
import '../../test_utils/mocks/mock_network_service.dart';
import '../../test_utils/mocks/mock_storage_service.dart';
import '../../test_utils/widget_finders.dart';

void main() {
  testWidgets('HomeScreen should have correct structure', (tester) async {
    networkService = MockNetworkService();
    secureStorageService = LoggedUserMockedSecureStorageService();
    storageService = MockStorageService();
    databaseService = MockDatabaseService();

    await initConfig();

    await tester.pumpWidget(MockFlutterTestApp());
    await tester.pump(const Duration(seconds: 20));

    final findWidgetByType = findAndGetWidgetByType(find, tester);
    final findWidgetByKey = findAndGetWidgetByKey(find, tester);

    final CustomAppBar appBar = findWidgetByType();
    expect(appBar.titleText, 'Home');

    final ScreenWithLoader screenWithLoader = findWidgetByType();
    expect(screenWithLoader.drawer, isInstanceOf<CustomDrawer>());

    await tester.pump(const Duration(seconds: 20));

    final ListView listView =
        findWidgetByKey(const ValueKey('bookCategoriesListView'));

    final children =
        (listView.childrenDelegate as SliverChildListDelegate).children;
    expect(children.length, bookCategoriesResults.entries.length);

    for (var child in children) {
      expect(child, isInstanceOf<Padding>());

      final padding = child as Padding;
      expect(padding.child, isInstanceOf<BookCategoryPreview>());
    }

    findWidgetByKey<IconButton>(const ValueKey('cartButton'));
    findWidgetByKey<IconButton>(const ValueKey('refreshButton'));
  });
}

class MockFlutterTestApp extends StatelessWidget {
  late final AppConfigurationController _appConfigurationController;

  MockFlutterTestApp({super.key}) {
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
        home: const HomeScreen(),
      ),
    );
  }
}
