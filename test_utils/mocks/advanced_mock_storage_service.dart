import 'package:flutter_test_app/services/storage_service/storage_service.dart';

class AdvancedMockStorageService extends StorageService<String> {
  final Map<String, String> _data = {};

  @override
  Future<void> clear() async {
    _data.clear();
  }

  @override
  Future<String?> read(String key) async {
    return _data[key];
  }

  @override
  Future<void> remove(String key) async {
    _data.remove(key);
  }

  @override
  Future<void> write(String key, value) async {
    _data[key] = value;
  }
}
