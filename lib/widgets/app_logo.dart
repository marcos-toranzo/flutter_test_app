import 'package:flutter/material.dart';
import 'package:flutter_test_app/widgets/space.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Image(
          image: AssetImage('assets/images/app_logo.png'),
          height: 160,
        ),
        const Space.vertical(20),
        Text(
          'Mobile App',
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.displaySmall?.fontSize!,
          ),
        ),
      ],
    );
  }
}
