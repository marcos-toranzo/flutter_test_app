import 'package:flutter/material.dart';
import 'package:flutter_test_app/app_configuration.dart';
import 'package:flutter_test_app/controllers/auth_controller.dart';
import 'package:flutter_test_app/controllers/cart_controller.dart';
import 'package:flutter_test_app/services/routing_service/routing_service.dart';
import 'package:flutter_test_app/utils/localization.dart';
import 'package:flutter_test_app/utils/notifications.dart';
import 'package:flutter_test_app/views/checkout/checkout_screen_controller.dart';
import 'package:flutter_test_app/views/checkout/payment_info_form/payment_info_form.dart';
import 'package:flutter_test_app/views/checkout/shipping_information_form.dart';
import 'package:flutter_test_app/views/home/home_screen.dart';
import 'package:flutter_test_app/widgets/buttons/wide_button.dart';
import 'package:flutter_test_app/widgets/custom_appbar.dart';
import 'package:flutter_test_app/widgets/page_with_loader.dart';
import 'package:flutter_test_app/widgets/space.dart';
import 'package:get/get.dart';

final _shippingInformationFormKey = GlobalKey<FormState>();
final _paymentDetailsFormKey = GlobalKey<FormState>();

class CheckoutScreen extends StatelessWidget {
  static const String routeName = '/checkout';

  final CartController _cartController = Get.find();
  final AuthController _authController = Get.find();

  CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final translations = AppTranslations.of(context);
    final toPay = RouteArguments.of(context).toPay!;
    const formFieldsAutovalidateMode = AutovalidateMode.onUserInteraction;

    final controller = Get.put(
      CheckoutScreenController(cartController: _cartController),
    );

    return Obx(
      () => PageWithLoader(
        loaderText: translations.loading,
        showLoader: controller.isLoading,
        child: Scaffold(
          appBar: CustomAppBar(
            titleText: translations.checkout,
            showCartButton: false,
          ),
          body: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(12),
            children: [
              ShippingInformationForm(
                formKey: _shippingInformationFormKey,
                userEmail: _authController.user?.email,
                nameController: controller.nameController,
                addressController: controller.addressController,
                countryController: controller.countryController,
                cityController: controller.cityController,
                zipCodeController: controller.zipCodeController,
                autovalidateMode: formFieldsAutovalidateMode,
              ),
              const Space.vertical(40),
              PaymentInfoForm(
                formKey: _paymentDetailsFormKey,
                cardNumberController: controller.cardNumberController,
                cardHolderNameController: controller.cardHolderNameController,
                cardExpDateController: controller.cardExpDateController,
                cardCVCController: controller.cardCVCController,
                autovalidateMode: formFieldsAutovalidateMode,
              ),
              const Space.vertical(60),
              WideButton(
                key: const ValueKey('payButton'),
                padding: const EdgeInsets.symmetric(horizontal: 40),
                text: '${translations.pay} ${toPay.format()}',
                onPressed: () {
                  final validShippingInformation =
                      _shippingInformationFormKey.currentState!.validate();
                  final validPaymentDetails =
                      _paymentDetailsFormKey.currentState!.validate();
                  if (validShippingInformation && validPaymentDetails) {
                    controller.onSubmit(
                      onError: () {
                        showSnackBar(
                          context: context,
                          text: translations.errorPaying,
                        );
                      },
                      onSuccess: () async {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => AlertDialog(
                            title: Text(translations.congrats),
                            content: Text(translations.paymentSuccessful),
                            actions: [
                              WideButton(
                                key: const ValueKey(
                                    'purchaseSuccessfulOkButton'),
                                onPressed: () {
                                  routingService.popUntil(
                                    context: context,
                                    untilRouteName: HomeScreen.routeName,
                                  );
                                },
                                text: translations.ok,
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
