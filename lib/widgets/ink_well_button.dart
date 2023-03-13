import 'package:flutter/material.dart';

class InkWellButton extends StatelessWidget {
  final double elevation;
  final BorderRadius? borderRadius;
  final bool transparent;
  final VoidCallback onTap;
  final Widget child;

  const InkWellButton({
    required this.onTap,
    required this.child,
    this.elevation = 0.0,
    this.borderRadius,
    this.transparent = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      borderRadius: borderRadius,
      color: transparent ? Colors.transparent : null,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onTap,
        child: child,
      ),
    );
  }
}
