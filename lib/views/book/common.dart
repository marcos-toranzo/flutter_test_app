import 'package:flutter/material.dart';

Color getLighterTextColor(BuildContext context) =>
    Theme.of(context).colorScheme.onBackground.withAlpha(150);

TextStyle? getBigTextStyle(BuildContext context) =>
    Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
        );
