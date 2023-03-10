import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PasswordIcon extends StatelessWidget {
  final double? size;
  final Color? color;

  const PasswordIcon({this.color, this.size, super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/password_icon.svg',
      color: color,
      height: size,
      width: size,
    );
  }
}
