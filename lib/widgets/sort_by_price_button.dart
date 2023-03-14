import 'package:flutter/material.dart';
import 'package:flutter_test_app/utils/localization.dart';
import 'package:flutter_test_app/utils/sorting.dart';
import 'package:flutter_test_app/utils/types.dart';
import 'package:flutter_test_app/widgets/buttons/custom_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SortByPriceButton extends StatefulWidget {
  final OnDataCallback<SortOrder> onSort;
  final bool transparent;
  final Color? backgroundColor;

  const SortByPriceButton({
    required this.onSort,
    this.transparent = false,
    this.backgroundColor,
    super.key,
  });

  @override
  State<SortByPriceButton> createState() => _SortByPriceButtonState();
}

class _SortByPriceButtonState extends State<SortByPriceButton> {
  SortOrder _sortOrder = SortOrder.none;

  @override
  Widget build(BuildContext context) {
    final translations = AppTranslations.of(context);

    late final IconData iconData;

    switch (_sortOrder) {
      case SortOrder.none:
        iconData = FontAwesomeIcons.bars;
        break;
      case SortOrder.ascending:
        iconData = FontAwesomeIcons.arrowUpWideShort;
        break;
      case SortOrder.descending:
        iconData = FontAwesomeIcons.arrowDownWideShort;
        break;
    }

    return CustomButton(
      transparent: widget.transparent,
      backgroundColor: widget.backgroundColor,
      onPressed: () {
        late final SortOrder newSortOrder;

        switch (_sortOrder) {
          case SortOrder.none:
            newSortOrder = SortOrder.descending;
            break;
          case SortOrder.descending:
            newSortOrder = SortOrder.ascending;
            break;
          case SortOrder.ascending:
            newSortOrder = SortOrder.none;
            break;
        }

        widget.onSort(newSortOrder);

        setState(() {
          _sortOrder = newSortOrder;
        });
      },
      text: translations.price,
      iconData: iconData,
      iconSize: 14,
    );
  }
}
