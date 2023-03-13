import 'package:flutter/material.dart';

class SimpleCard extends StatelessWidget {
  final Widget child;
  final BorderRadius? borderRadius;
  final double elevation;

  const SimpleCard({
    required this.child,
    this.borderRadius,
    this.elevation = 0.0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      borderRadius: borderRadius,
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor.withAlpha(255),
          borderRadius: borderRadius,
        ),
        child: child,
      ),
    );
  }
}
