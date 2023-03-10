import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test_app/services/storage_service/storage_service.dart';

/// Storage service that uses FlutterSecureStorage Flutter package
///
/// See https://pub.dev/packages/flutter_secure_storage for more information about package
class FlutterSecureStorageStorageService implements StorageService<String> {
  final _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  @override
  Future<void> clear() async {
    await _storage.deleteAll();
  }

  @override
  Future<String?> read(String key) async {
    return _storage.read(key: key);
  }

  @override
  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  @override
  Future<void> remove(String key) async {
    await _storage.delete(key: key);
  }
}
