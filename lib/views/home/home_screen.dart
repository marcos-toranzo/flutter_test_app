import 'package:flutter/material.dart';
import 'package:flutter_test_app/utils/localization.dart';
import 'package:flutter_test_app/widgets/custom_appbar.dart';
import 'package:flutter_test_app/widgets/custom_drawer.dart';
import 'package:flutter_test_app/widgets/double_dismiss_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final translations = AppTranslations.of(context);

    return DoubleDismissScreen(
      child: Scaffold(
        appBar: CustomAppBar(titleText: translations.home),
        drawer: CustomDrawer(),
      ),
    );
  }
}
