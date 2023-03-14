import 'package:flutter/material.dart';
import 'package:flutter_test_app/widgets/buttons/ink_well_button.dart';

class SimpleCard extends StatelessWidget {
  final Widget child;
  final BorderRadius? borderRadius;
  final double elevation;
  final VoidCallback? onTap;

  const SimpleCard({
    required this.child,
    this.borderRadius,
    this.onTap,
    this.elevation = 0.5,
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
        child: onTap != null
            ? InkWellButton(
                borderRadius: borderRadius,
                onTap: onTap,
                child: child,
              )
            : child,
      ),
    );
  }
}
