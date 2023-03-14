import 'package:flutter/material.dart';

class InkWellButton extends StatelessWidget {
  final double elevation;
  final BorderRadius? borderRadius;
  final bool transparent;
  final VoidCallback onTap;
  final Widget child;
  final Color? backgroundColor;

  const InkWellButton({
    required this.onTap,
    required this.child,
    this.elevation = 0.0,
    this.borderRadius,
    this.backgroundColor,
    this.transparent = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      borderRadius: borderRadius,
      color: backgroundColor ?? (transparent ? Colors.transparent : null),
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onTap,
        child: child,
      ),
    );
  }
}
