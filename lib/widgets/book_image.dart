import 'package:flutter/material.dart';
import 'package:flutter_test_app/utils/styling.dart';

class BookImage extends StatelessWidget {
  final String? imageUrl;
  final BoxFit fit;
  final double? height;
  final double? width;
  final double elevation;

  const BookImage({
    required this.imageUrl,
    super.key,
    this.fit = BoxFit.cover,
    this.height,
    this.width,
    this.elevation = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(borderRadiusValue);

    return Material(
      borderRadius: borderRadius,
      elevation: elevation,
      color: Colors.transparent,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: imageUrl != null
            ? Image.network(
                imageUrl!,
                width: width,
                height: height,
                fit: fit,
              )
            : Image.asset(
                'assets/images/book_cover_placeholder.png',
                width: width,
                height: height,
                fit: fit,
              ),
      ),
    );
  }
}
