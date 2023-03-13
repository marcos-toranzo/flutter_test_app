import 'package:flutter/material.dart';
import 'package:flutter_test_app/utils/iterable_utils.dart';
import 'package:flutter_test_app/utils/localization.dart';
import 'package:flutter_test_app/widgets/cutom_text.dart';

class CartBookTitleAndAuthors extends StatelessWidget {
  final String? title;
  final List<String>? authors;

  const CartBookTitleAndAuthors({
    required this.title,
    required this.authors,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final translations = AppTranslations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OnBackgroundText(
          title ?? translations.untitled,
          maxLines: 3,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        ...(authors != null
            ? authors!.mapList(
                (author) => OnBackgroundText(author),
              )
            : [OnBackgroundText(translations.unknownAuthors)]),
      ],
    );
  }
}
