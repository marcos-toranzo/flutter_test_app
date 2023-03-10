import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test_app/services/network_service/http_network_service.dart';
import 'package:flutter_test_app/services/network_service/network_service.dart';
import 'package:flutter_test_app/services/routing_service/getx_routing_service.dart';
import 'package:flutter_test_app/services/routing_service/routing_service.dart';
import 'package:flutter_test_app/services/storage_service/flutter_secure_storage_storage_service.dart';
import 'package:flutter_test_app/services/storage_service/shared_preferences_storage_service.dart';
import 'package:flutter_test_app/services/storage_service/storage_service.dart';
import 'package:flutter_test_app/utils/logging.dart';

final NetworkService networkService = HttpNetworkService();
final StorageService<String> storageService = SharedPreferencesStorageService();
final StorageService<String> secureStorageService =
    FlutterSecureStorageStorageService();
final RoutingService routingService = GetXRoutingService();
final Logger logger = kDebugMode ? DebugLogger() : ReleaseLogger();

class Environment {
  static const valueOnNotFoundKey = 'NOT_FOUND';
  static const fileName = kReleaseMode ? '.env' : '.env.dev';

  static String _getVariable(String key) => dotenv.get(
        key,
        fallback: valueOnNotFoundKey,
      );

  static String get accessTokenKey => _getVariable('ACCESS_TOKEN_KEY');
  static String get savedLanguageKey => _getVariable('SAVED_LANGUAGE_KEY');
  static String get savedThemeKey => _getVariable('SAVED_THEME_KEY');

  static String get apiBaseUrl => Platform.isAndroid
      ? _getVariable('API_BASE_URL_ANDROID')
      : _getVariable('API_BASE_URL_IOS');

  static String get userEndpoint => _getVariable('USER_ENDPOINT');
  static String get loginEndpoint => _getVariable('LOGIN_ENDPOINT');
  static String get registerEndpoint => _getVariable('REGISTER_ENDPOINT');
}

// Class for bypassing CERTIFICATE_VERIFY_FAILED error on local develpment
class _HttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> initConfig() async {
  await dotenv.load(fileName: Environment.fileName);

  if (kDebugMode) {
    // Override normal behavior with mock implementation to accept certificates
    // on local development
    HttpOverrides.global = _HttpOverrides();
  }
}
