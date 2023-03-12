import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test_app/widgets/cutom_text.dart';
import 'package:flutter_test_app/widgets/space.dart';

class AppLogo extends StatelessWidget {
  final bool includeText;
  final double size;

  const AppLogo({
    required this.size,
    this.includeText = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          'assets/images/app_logo.svg',
          height: size,
          width: size,
        ),
        const Space.vertical(20),
        if (includeText)
          OnBackgroundText(
            'Mobile App',
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.displaySmall?.fontSize!,
            ),
          ),
      ],
    );
  }
}
