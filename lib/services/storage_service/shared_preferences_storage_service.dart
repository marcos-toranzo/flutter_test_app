import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_test_app/services/storage_service/storage_service.dart';

/// Storage service that uses SharedPreferences Flutter package
///
/// See https://pub.dev/packages/shared_preferences for more information about package
class SharedPreferencesStorageService implements StorageService<String> {
  SharedPreferences? _inst;

  @override
  Future<bool> clear() async {
    return (await _instance).clear();
  }

  @override
  Future<String?> read(String key) async {
    return (await _instance).getString(key);
  }

  @override
  Future<bool> write(String key, String value) async {
    return (await _instance).setString(key, value);
  }

  @override
  Future<void> remove(String key) async {
    await (await _instance).remove(key);
  }

  Future<SharedPreferences> get _instance async =>
      _inst ?? await SharedPreferences.getInstance();
}
