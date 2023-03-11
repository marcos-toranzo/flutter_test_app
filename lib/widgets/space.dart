import 'package:flutter/material.dart';

class Space extends StatelessWidget {
  final double height;
  final double width;

  const Space({
    required this.height,
    required this.width,
    super.key,
  });

  const Space.vertical(this.height, {super.key}) : width = 0;

  const Space.horizontal(this.width, {super.key}) : height = 0;

  const Space.square(double size, {super.key})
      : width = size,
        height = size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height, width: width);
  }
}
