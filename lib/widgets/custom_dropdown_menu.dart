import 'package:flutter/material.dart';
import 'package:flutter_test_app/utils/iterable_utils.dart';
import 'package:flutter_test_app/utils/types.dart';
import 'package:flutter_test_app/widgets/space.dart';

class CustomDropdownMenuElement<T> {
  final String text;
  final Widget icon;
  final double? iconSize;
  final T value;

  const CustomDropdownMenuElement({
    required this.icon,
    required this.value,
    required this.text,
    this.iconSize,
  });
}

class CustomDropdownMenu<T> extends StatelessWidget {
  final OnChangedCallback<T?> onChanged;
  final T value;
  final List<CustomDropdownMenuElement> items;

  const CustomDropdownMenu({
    super.key,
    required this.onChanged,
    required this.value,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<T>(
        alignment: Alignment.centerRight,
        isDense: true,
        icon: const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Icon(Icons.expand_more),
        ),
        value: value,
        items: items.mapList(
          (item) => DropdownMenuItem(
            value: item.value,
            child: Row(
              children: [
                SizedBox.square(
                  dimension: item.iconSize ?? 20,
                  child: Center(child: item.icon),
                ),
                const Space.horizontal(10),
                Text(
                  item.text,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
