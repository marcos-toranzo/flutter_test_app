import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;
  final List<Widget>? actions;
  final VoidCallback? onRefresh;

  const CustomAppBar(
      {required this.titleText, this.actions, this.onRefresh, super.key});

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(titleText),
      actions: [
        if (actions != null) ...actions!,
        if (onRefresh != null)
          IconButton(
            onPressed: onRefresh,
            icon: const Icon(FontAwesomeIcons.arrowsRotate),
          ),
      ],
    );
  }
}
