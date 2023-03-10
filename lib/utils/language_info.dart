import 'package:flutter/material.dart';

final languageInfoMap = {
  'es': LanguageInfo(
    name: 'Español',
    flag: Image.asset('assets/images/es_flag.png'),
  ),
  'en': LanguageInfo(
    name: 'English',
    flag: Image.asset('assets/images/us_flag.png'),
  ),
};

class LanguageInfo {
  final String name;
  final Image flag;

  const LanguageInfo({
    required this.name,
    required this.flag,
  });
}
