import 'package:flutter/material.dart';
import 'package:flutter_test_app/utils/styling.dart';
import 'package:cached_network_image/cached_network_image.dart';

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

    final imagePlaceholder = Image.asset(
      'assets/images/book_cover_placeholder.png',
      width: width,
      height: height,
      fit: fit,
    );

    return Material(
      borderRadius: borderRadius,
      elevation: elevation,
      color: Colors.transparent,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: imageUrl != null
            ? CachedNetworkImage(
                imageUrl: imageUrl!,
                height: height,
                width: width,
                fit: fit,
                placeholder: (_, __) => SizedBox(
                  height: height,
                  width: width,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      imagePlaceholder,
                      const CircularProgressIndicator(),
                    ],
                  ),
                ),
                errorWidget: (_, __, ___) => imagePlaceholder,
              )
            : imagePlaceholder,
      ),
    );
  }
}
