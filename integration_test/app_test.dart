import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_app/app_configuration.dart';
import 'package:flutter_test_app/views/cart/cart_checkout_fab.dart';
import 'package:flutter_test_app/views/checkout/payment_info_form/card_cvv_form_field.dart';
import 'package:flutter_test_app/views/checkout/payment_info_form/card_expiration_date_form_field.dart';
import 'package:flutter_test_app/views/checkout/payment_info_form/card_number_form_field.dart';
import 'package:flutter_test_app/views/login_signup/login_signup_form/email_form_field.dart';
import 'package:flutter_test_app/views/login_signup/login_signup_form/password_form_field.dart';
import 'package:flutter_test_app/widgets/buttons/ink_well_button.dart';
import 'package:flutter_test_app/widgets/buttons/wide_button.dart';
import 'package:flutter_test_app/widgets/custom_appbar.dart';
import 'package:flutter_test_app/widgets/form_fields/custom_text_form_field.dart';
import 'package:integration_test/integration_test.dart';

import 'package:flutter_test_app/main.dart' as app;

import '../test_utils/mocks/mock_network_service.dart';
import '../test_utils/mocks/mock_secure_storage_service.dart';
import '../test_utils/mocks/mock_storage_service.dart';
import '../test_utils/widget_finders.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('Log in, go to book, add to cart, checkout, pay',
        (tester) async {
      app.main();

      networkService = MockNetworkService();
      secureStorageService = MockSecureStorageService();
      storageService = MockStorageService();

      // main is async. We have to wait.
      await tester.pump(const Duration(seconds: 5));
      await tester.pumpAndSettle();

      final findWidgetByType = findAndGetWidgetByType(find, tester);
      final findWidgetByKey = findAndGetWidgetByKey(find, tester);

      final EmailFormField emailFormField = findWidgetByType();
      final PasswordFormField passwordFormField = findWidgetByType();
      final WideButton loginButton = findWidgetByType();

      emailFormField.controller.text = 'user@email.com';
      passwordFormField.controller.text = 'a';

      loginButton.onPressed();

      // wait for home to load
      await tester.pump(const Duration(seconds: 5));
      await tester.pumpAndSettle();

      final bookPreviewFinder =
          find.byKey(const ValueKey('book#$fictionBookId'));
      final inkWellButtonFinder = find.byType(InkWellButton);
      final bookPreviewInkWellButtonFinder = find.descendant(
        of: bookPreviewFinder,
        matching: inkWellButtonFinder,
      );

      final InkWellButton inkWellButton =
          tester.widget(bookPreviewInkWellButtonFinder);

      inkWellButton.onTap!();

      // wait for book details screen to load
      await tester.pump(const Duration(seconds: 5));
      await tester.pumpAndSettle();

      final WideButton addToCartButton = findWidgetByType();

      addToCartButton.onPressed();

      // wait for cart screen to load
      await tester.pump(const Duration(seconds: 5));
      await tester.pumpAndSettle();

      final CartCheckoutFAB cartCheckoutFABButton = findWidgetByType();

      cartCheckoutFABButton.onPressed();

      // wait for checkout screen to load
      await tester.pump(const Duration(seconds: 5));
      await tester.pumpAndSettle();

      final CustomTextFormField nameFormField = findWidgetByKey(
        const ValueKey('shippingInfoFormNameField'),
      );
      final CustomTextFormField addressFormField = findWidgetByKey(
        const ValueKey('shippingInfoFormAddressField'),
      );
      final CustomTextFormField countryFormField = findWidgetByKey(
        const ValueKey('shippingInfoFormCountryField'),
      );
      final CustomTextFormField cityFormField = findWidgetByKey(
        const ValueKey('shippingInfoFormCityField'),
      );
      final CustomTextFormField zipCodeFormField = findWidgetByKey(
        const ValueKey('shippingInfoFormZipCodeField'),
      );

      final CardNumberFormField cardNumberFormField = findWidgetByType();
      final CustomTextFormField cardHolderNameFormField = findWidgetByKey(
        const ValueKey('paymentInfoFormCardHolderNameField'),
      );
      final CardExpirationDateFormField cardExpirationDateFormField =
          findWidgetByType();
      final CardCvcFormField cardCvcFormField = findWidgetByType();

      nameFormField.controller!.text = 'a';
      addressFormField.controller!.text = 'a';
      countryFormField.controller!.text = 'a';
      cityFormField.controller!.text = 'a';
      zipCodeFormField.controller!.text = '11234';
      cardNumberFormField.controller.text = '5555 5555 5555 5555';
      cardHolderNameFormField.controller!.text = 'a';
      cardExpirationDateFormField.controller.text = '03/29';
      cardCvcFormField.controller.text = '222';

      final WideButton payButon = findWidgetByKey(const ValueKey('payButton'));

      payButon.onPressed();

      // wait for popup to show
      await tester.pump(const Duration(seconds: 5));
      await tester.pumpAndSettle();

      final WideButton okButton =
          findWidgetByKey(const ValueKey('purchaseSuccessfulOkButton'));

      okButton.onPressed();

      // wait for home screen to load
      await tester.pump(const Duration(seconds: 5));
      await tester.pumpAndSettle();

      final CustomAppBar customAppBar = findWidgetByType();

      expect(customAppBar.titleText, 'Home');
    });
  });
}
