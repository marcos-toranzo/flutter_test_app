import 'package:flutter/material.dart';

const primaryColor = Color(0xFF5371FF);
const secondaryColor = Color(0xFF37B6FF);

final darkAppTheme = ThemeData.dark(
  useMaterial3: true,
).copyWith(
  primaryColor: primaryColor,
  colorScheme: const ColorScheme.dark(
    primary: primaryColor,
    secondary: secondaryColor,
  ),
);

final lightAppTheme = ThemeData(
  useMaterial3: true,
  primaryColor: primaryColor,
  primarySwatch: toMaterialColor(primaryColor),
  colorScheme: const ColorScheme.light(
    primary: primaryColor,
    secondary: secondaryColor,
  ),
);

MaterialColor toMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }

  final r = color.red;
  final g = color.green;
  final b = color.blue;

  for (var strength in strengths) {
    final double ds = 0.5 - strength;

    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }

  return MaterialColor(color.value, swatch);
}
