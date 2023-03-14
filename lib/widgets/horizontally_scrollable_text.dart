import 'package:flutter/material.dart';
import 'package:flutter_test_app/widgets/cutom_text.dart';

class HorizontallyScrollableText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final bool isInsideRow;

  late final Widget _child;

  HorizontallyScrollableText(
    this.text, {
    this.style,
    this.isInsideRow = false,
    super.key,
  }) {
    _child = Text(
      text,
      style: style,
    );
  }

  HorizontallyScrollableText.onBackground(
    this.text, {
    this.style,
    this.isInsideRow = false,
    super.key,
  }) {
    _child = OnBackgroundText(
      text,
      style: style,
    );
  }

  @override
  Widget build(BuildContext context) {
    final widget = Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: _child,
      ),
    );

    return isInsideRow ? widget : Row(children: [widget]);
  }
}
