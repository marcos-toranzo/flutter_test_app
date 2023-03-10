import 'package:flutter_test_app/app_configuration.dart';

Future<void> storeTokens({
  required String accessToken,
}) async {
  await secureStorageService.write(Environment.accessTokenKey, accessToken);
}

Future<void> eraseTokens() async {
  await secureStorageService.remove(Environment.accessTokenKey);
}

Future<String?> loadAccessToken() async {
  return await secureStorageService.read(Environment.accessTokenKey);
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
