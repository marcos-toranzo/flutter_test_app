import 'package:flutter/material.dart';

class OnBackgroundText extends StatelessWidget {
  final String data;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;

  const OnBackgroundText(
    this.data, {
    this.style,
    this.overflow,
    this.textAlign,
    this.maxLines,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onBackground;

    return Text(
      data,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: style?.copyWith(color: color) ?? TextStyle(color: color),
    );
  }
}
