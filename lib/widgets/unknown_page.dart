import 'package:flutter/material.dart';
import 'package:flutter_test_app/app_configuration.dart';
import 'package:flutter_test_app/utils/localization.dart';
import 'package:flutter_test_app/widgets/space.dart';
import 'package:flutter_test_app/widgets/wide_button.dart';

class UnknownPage extends StatelessWidget {
  const UnknownPage({super.key});

  @override
  Widget build(BuildContext context) {
    final translations = AppTranslations.of(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('assets/images/sad_face.png'),
              height: 120,
            ),
            const Space.vertical(30),
            Text(
              translations.invalidScreenError,
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
              ),
            ),
            WideButton(
              padding: const EdgeInsets.symmetric(
                horizontal: 32.0,
                vertical: 24.0,
              ),
              text: translations.goBack,
              onPressed: () => routingService.popRoute(context),
            ),
          ],
        ),
      ),
    );
  }
}
