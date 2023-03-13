import 'package:flutter/material.dart';
import 'package:flutter_test_app/utils/styling.dart';
import 'package:flutter_test_app/widgets/book/book_image.dart';

class BookHeader extends StatelessWidget {
  final String? imageLink;

  const BookHeader({
    required this.imageLink,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withAlpha(40),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(borderRadiusValue * 3),
              bottomRight: Radius.circular(borderRadiusValue * 3),
            ),
          ),
          height: 180,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: BookImage(
            imageUrl: imageLink,
            elevation: 0,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
