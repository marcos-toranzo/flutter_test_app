import 'package:flutter/material.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_app/app_configuration.dart';
import 'package:flutter_test_app/controllers/app_configuration_controller.dart';
import 'package:flutter_test_app/controllers/auth_controller.dart';
import 'package:flutter_test_app/controllers/cart_controller.dart';
import 'package:flutter_test_app/models/book.dart';
import 'package:flutter_test_app/widgets/book/book_image.dart';
import 'package:flutter_test_app/widgets/book/book_preview.dart';
import 'package:flutter_test_app/widgets/book/book_price_tag.dart';
import 'package:flutter_test_app/widgets/buttons/ink_well_button.dart';
import 'package:flutter_test_app/widgets/column_with_padding.dart';
import 'package:flutter_test_app/utils/localization.dart';
import 'package:flutter_test_app/widgets/custom_appbar.dart';
import 'package:flutter_test_app/widgets/cutom_text.dart';
import 'package:get/get.dart';

import '../../test_utils/mocks/data.dart';
import '../../test_utils/mocks/logged_user_mock_secure_storage_service.dart';
import '../../test_utils/mocks/mock_database_service.dart';
import '../../test_utils/mocks/mock_storage_service.dart';
import '../../test_utils/widget_finders.dart';

void main() {
  final book = Book.fromJson(fictionBook);

  testWidgets('BookPreview should have correct structure', (tester) async {
    databaseService = MockDatabaseService();
    secureStorageService = LoggedUserMockedSecureStorageService();
    storageService = MockStorageService();
    databaseService = MockDatabaseService();

    await initConfig();

    await tester.pumpWidget(MockFlutterTestAppWithBookPreview(book: book));
    await tester.pump(const Duration(seconds: 20));

    final findWidgetByType = findAndGetWidgetByType(find, tester);

    final ColumnWithPadding columnWithPadding = findWidgetByType();

    expect(columnWithPadding.children.length, 5);

    var expanded = columnWithPadding.children[0];
    var sizedBox = columnWithPadding.children[2];
    var bookPriceTag = columnWithPadding.children[4];

    expect(expanded, isInstanceOf<Expanded>());
    expect(sizedBox, isInstanceOf<SizedBox>());
    expect(bookPriceTag, isInstanceOf<BookPriceTag>());

    expanded = expanded as Expanded;
    sizedBox = sizedBox as SizedBox;
    bookPriceTag = bookPriceTag as BookPriceTag;

    var bookImage = expanded.child;
    var title = sizedBox.child;

    expect(bookImage, isInstanceOf<BookImage>());
    expect(title, isInstanceOf<OnBackgroundText>());

    bookImage = bookImage as BookImage;
    title = title as OnBackgroundText;

    expect(bookImage.imageUrl, book.imageLink);
    expect(title.data, book.title);
    expect(bookPriceTag.price, book.price);
    expect(bookPriceTag.saleability, book.saleability);
  });

  testWidgets('BookPreview should go to book details on tap', (tester) async {
    databaseService = MockDatabaseService();
    secureStorageService = LoggedUserMockedSecureStorageService();
    storageService = MockStorageService();
    databaseService = MockDatabaseService();

    await initConfig();

    await tester.pumpWidget(MockFlutterTestAppWithBookPreview(book: book));
    await tester.pump(const Duration(seconds: 20));

    final findWidgetByType = findAndGetWidgetByType(find, tester);

    final InkWellButton inkWellButton = findWidgetByType();

    inkWellButton.onTap!();

    await tester.pump(const Duration(seconds: 20));
    await tester.pumpAndSettle();

    final CustomAppBar customAppBar = findWidgetByType();

    expect(customAppBar.titleText, 'Book Details');
  });
}

class MockFlutterTestAppWithBookPreview extends StatelessWidget {
  late final AppConfigurationController _appConfigurationController;
  final Book book;

  MockFlutterTestAppWithBookPreview({super.key, required this.book}) {
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
        home: BookPreview(book: book),
      ),
    );
  }
}
