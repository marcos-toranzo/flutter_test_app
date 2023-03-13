import 'package:flutter/material.dart';
import 'package:flutter_test_app/utils/localization.dart';
import 'package:flutter_test_app/views/book/common.dart';
import 'package:flutter_test_app/widgets/cutom_text.dart';
import 'package:flutter_test_app/widgets/space.dart';

class BookDescription extends StatelessWidget {
  final String description;

  const BookDescription({
    required this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final translations = AppTranslations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OnBackgroundText(
          translations.description,
          style: getBigTextStyle(context),
        ),
        const Space.vertical(10),
        Text(
          description,
          textAlign: TextAlign.justify,
          style: TextStyle(color: getLighterTextColor(context)),
        ),
      ],
    );
  }
}
