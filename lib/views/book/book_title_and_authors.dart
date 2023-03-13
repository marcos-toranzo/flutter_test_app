import 'package:flutter/material.dart';
import 'package:flutter_test_app/utils/iterable_utils.dart';
import 'package:flutter_test_app/utils/localization.dart';
import 'package:flutter_test_app/widgets/cutom_text.dart';
import 'package:flutter_test_app/widgets/space.dart';

class BookTitleAndAuthors extends StatelessWidget {
  final String? title;
  final List<String>? authors;

  const BookTitleAndAuthors({
    required this.title,
    required this.authors,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final translations = AppTranslations.of(context);

    return Column(
      children: [
        OnBackgroundText(
          title ?? translations.untitled,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const Space.vertical(8),
        const Divider(
          thickness: 0.1,
          height: 8,
          endIndent: 30,
          indent: 30,
        ),
        ...(authors != null
            ? authors!.mapList(
                (author) => Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: OnBackgroundText(
                    author,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              )
            : [OnBackgroundText(translations.unknownAuthors)])
      ],
    );
  }
}
