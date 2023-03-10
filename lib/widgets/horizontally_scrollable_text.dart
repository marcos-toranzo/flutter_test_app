import 'package:flutter/material.dart';

class HorizontallyScrollableText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final bool isInsideRow;

  const HorizontallyScrollableText(
    this.text, {
    this.style,
    this.isInsideRow = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final widget = Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Text(text, style: style),
      ),
    );

    return isInsideRow ? widget : Row(children: [widget]);
  }
}
