import 'package:flutter/material.dart';
import 'package:flutter_test_app/controllers/auth_controller.dart';
import 'package:flutter_test_app/utils/iterable_utils.dart';
import 'package:flutter_test_app/utils/localization.dart';
import 'package:flutter_test_app/utils/notifications.dart';
import 'package:flutter_test_app/views/home/book_category_view.dart';
import 'package:flutter_test_app/views/home/constants.dart';
import 'package:flutter_test_app/views/home/home_controller.dart';
import 'package:flutter_test_app/widgets/custom_appbar.dart';
import 'package:flutter_test_app/widgets/custom_drawer.dart';
import 'package:flutter_test_app/widgets/double_dismiss_screen.dart';
import 'package:flutter_test_app/widgets/page_with_loader.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';

  final AuthController _authController = Get.find();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    final translations = AppTranslations.of(context);

    return DoubleDismissScreen(
      child: Obx(
        () => PageWithLoader(
          loaderText: translations.loading,
          showLoader: controller.isLoading,
          child: Scaffold(
            appBar: CustomAppBar(
              titleText: translations.home,
              cart: _authController.user?.cart,
              onRefresh: () {
                controller.onRefresh(
                  onError: () {
                    showSnackBar(
                      context: context,
                      text: translations.errorFetchingBooks,
                    );
                  },
                );
              },
              onCartPressed: () {},
            ),
            drawer: CustomDrawer(),
            body: ListView(
              padding: const EdgeInsets.only(top: 12),
              physics: const BouncingScrollPhysics(),
              children: controller.bookCategories.mapList(
                (bookCategory) => Padding(
                  padding: const EdgeInsets.only(
                    bottom: paddingValue,
                    left: 10,
                    right: 10,
                  ),
                  child: BookCategoryView(bookCategory: bookCategory),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
