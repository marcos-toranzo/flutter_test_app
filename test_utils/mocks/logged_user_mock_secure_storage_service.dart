import 'package:flutter_test_app/services/storage_service/storage_service.dart';

class LoggedUserMockedSecureStorageService extends StorageService<String> {
  @override
  Future<void> clear() async {}

  @override
  Future<String?> read(String key) async {
    return '0';
  }

  @override
  Future<void> remove(String key) async {}

  @override
  Future<void> write(String key, value) async {}
}
