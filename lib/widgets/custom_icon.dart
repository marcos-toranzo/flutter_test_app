import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomIcon extends StatelessWidget {
  final double? size;
  final Color? color;
  late final String _url;

  CustomIcon.email({this.color, this.size, super.key}) {
    _url = 'assets/icons/email_icon.svg';
  }
  
  CustomIcon.password({this.color, this.size, super.key}) {
    _url = 'assets/icons/password_icon.svg';
  }

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      _url,
      color: color,
      height: size,
      width: size,
    );
  }
}