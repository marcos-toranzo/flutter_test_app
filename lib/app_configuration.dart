import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test_app/services/database_service/database_service.dart';
import 'package:flutter_test_app/services/database_service/sqflite_database_service.dart';
import 'package:flutter_test_app/services/network_service/http_network_service.dart';
import 'package:flutter_test_app/services/network_service/network_service.dart';
import 'package:flutter_test_app/services/routing_service/getx_routing_service.dart';
import 'package:flutter_test_app/services/routing_service/routing_service.dart';
import 'package:flutter_test_app/services/storage_service/flutter_secure_storage_storage_service.dart';
import 'package:flutter_test_app/services/storage_service/shared_preferences_storage_service.dart';
import 'package:flutter_test_app/services/storage_service/storage_service.dart';
import 'package:flutter_test_app/utils/logging.dart';

NetworkService networkService = HttpNetworkService();
StorageService<String> storageService = SharedPreferencesStorageService();
StorageService<String> secureStorageService =
    FlutterSecureStorageStorageService();
DatabaseService databaseService = SqfliteDatabaseService();
final RoutingService routingService = GetXRoutingService();
final Logger logger = kDebugMode ? DebugLogger() : ReleaseLogger();

const databaseName = 'database.db';

class Environment {
  static const valueOnNotFoundKey = 'NOT_FOUND';
  static const fileName = kReleaseMode ? '.env' : '.env.dev';

  static String _getVariable(String key) => dotenv.get(
        key,
        fallback: valueOnNotFoundKey,
      );

  static String get googleBooksApiBaseUrl =>
      _getVariable('GOOGLE_BOOKS_API_BASE_URL');
  static String get googleBooksApiKey => _getVariable('GOOGLE_BOOKS_API_KEY');

  static String get userIdKey => _getVariable('USER_ID_KEY');
  static String get savedLanguageKey => _getVariable('SAVED_LANGUAGE_KEY');
  static String get savedThemeKey => _getVariable('SAVED_THEME_KEY');
}

Future<void> initConfig() async {
  await dotenv.load(fileName: Environment.fileName);
  await databaseService.open(databaseName);
}
