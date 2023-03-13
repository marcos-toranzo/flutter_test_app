import 'package:flutter/material.dart';

class CounterButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool enabled;
  final IconData iconData;

  const CounterButton({
    required this.onTap,
    required this.iconData,
    this.enabled = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enabled ? onTap : () {},
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Icon(
          iconData,
          color: enabled
              ? Theme.of(context).primaryColor
              : Theme.of(context).disabledColor,
          size: 15,
        ),
      ),
    );
  }
}
