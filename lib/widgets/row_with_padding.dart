import 'package:flutter/material.dart';

class RowWithPadding extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final TextBaseline? textBaseline;

  const RowWithPadding({
    required this.padding,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textBaseline,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        textBaseline: textBaseline,
        children: children,
      ),
    );
  }
}
