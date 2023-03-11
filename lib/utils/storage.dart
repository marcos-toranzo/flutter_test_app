import 'package:flutter_test_app/app_configuration.dart';
import 'package:flutter_test_app/utils/types.dart';

Future<void> storeUserId(Id id) async {
  await secureStorageService.write(Environment.userIdKey, id);
}

Future<void> eraseUserId() async {
  await secureStorageService.remove(Environment.userIdKey);
}

Future<String?> loadUserId() async {
  return await secureStorageService.read(Environment.userIdKey);
}

Future<void> storeLanguage(String language) async {
  await storageService.write(Environment.savedLanguageKey, language);
}

Future<String?> loadSavedLanguage() async {
  return await storageService.read(Environment.savedLanguageKey);
}

Future<void> storeTheme(String theme) async {
  await storageService.write(Environment.savedThemeKey, theme);
}

Future<String?> loadSavedTheme() async {
  return await storageService.read(Environment.savedThemeKey);
}
