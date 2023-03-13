import 'package:flutter/material.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:flutter_test_app/models/book.dart';
import 'package:flutter_test_app/utils/iterable_utils.dart';
import 'package:flutter_test_app/utils/localization.dart';
import 'package:flutter_test_app/widgets/column_with_padding.dart';
import 'package:flutter_test_app/widgets/cutom_text.dart';
import 'package:flutter_test_app/widgets/space.dart';
import 'package:flutter_test_app/views/book/common.dart';

class BookDetails extends StatelessWidget {
  final Book book;

  const BookDetails({
    required this.book,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final translations = AppTranslations.of(context);

    buildDetailRow({required String header, required List<String> values}) {
      return TableRow(
        children: [
          TableCell(
            child: OnBackgroundText(
              header,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          TableCell(
            child: ColumnWithPadding(
              mainAxisSize: MainAxisSize.min,
              padding: const EdgeInsets.only(left: 20, bottom: 3.0),
              crossAxisAlignment: CrossAxisAlignment.start,
              children: values.mapList(
                (value) => Text(
                  value,
                  style: TextStyle(color: getLighterTextColor(context)),
                ),
              ),
            ),
          ),
        ],
      );
    }

    final publisher = book.publisher;
    final publishedDate = book.publishedDate;
    final language = book.language;
    final categories = book.categories;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OnBackgroundText(
          translations.details,
          style: getBigTextStyle(context),
        ),
        const Space.vertical(10),
        Row(
          children: [
            Expanded(
              child: Table(
                defaultColumnWidth: const IntrinsicColumnWidth(),
                children: [
                  if (publisher != null)
                    buildDetailRow(
                      header: translations.publisher,
                      values: [publisher],
                    ),
                  if (publishedDate != null)
                    buildDetailRow(
                      header: translations.publishedDate,
                      values: [publishedDate],
                    ),
                  if (language != null)
                    buildDetailRow(
                      header: translations.language,
                      values: [
                        LocaleNames.of(context)!.nameOf(language) ?? language,
                      ],
                    ),
                  if (categories != null)
                    buildDetailRow(
                      header: translations.categories(categories.length),
                      values: categories.mapList(
                        (category) =>
                            '${categories.length > 1 ? '• ' : ''}$category',
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
