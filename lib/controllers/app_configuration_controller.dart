import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_test_app/utils/storage.dart';

class AppConfigurationController extends GetxController {
  final _selectedLocale = Rx<Locale?>(null);
  Locale? get selectedLocale => _selectedLocale.value;

  final _appThemeMode = ThemeMode.light.obs;
  ThemeMode get appThemeMode => _appThemeMode.value;

  AppConfigurationController(List<Locale> supportedLocales) {
    _loadSavedLocale(supportedLocales);
    _loadSavedTheme();
  }

  Future<void> changeLocale(Locale newLocale) async {
    await storeLanguage(newLocale.languageCode);

    _selectedLocale.value = newLocale;
  }

  Future<void> changeThemeMode(ThemeMode themeMode) async {
    await storeTheme(themeMode.toString());

    _appThemeMode.value = themeMode;
  }

  void _loadSavedLocale(List<Locale> supportedLocales) async {
    final String? savedLanguageCode = await loadSavedLanguage();

    final newLocale = supportedLocales.firstWhereOrNull(
        (supportedLocale) => supportedLocale.languageCode == savedLanguageCode);

    if (newLocale != null) {
      _selectedLocale.value = newLocale;
    }
  }

  void _loadSavedTheme() async {
    final String? savedTheme = await loadSavedTheme();

    final newSavedTheme = ThemeMode.values
        .firstWhereOrNull((themeMode) => themeMode.toString() == savedTheme);

    if (newSavedTheme != null) {
      _appThemeMode.value = newSavedTheme;
    }
  }
}
