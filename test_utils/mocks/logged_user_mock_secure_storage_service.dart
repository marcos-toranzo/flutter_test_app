import 'package:flutter_test_app/services/storage_service/storage_service.dart';
import 'package:flutter_test_app/api/user_repository.dart';

class LoggedUserMockedSecureStorageService extends StorageService<String> {
  @override
  Future<void> clear() async {}

  @override
  Future<String?> read(String key) async {
    return user.id;
  }

  @override
  Future<void> remove(String key) async {}

  @override
  Future<void> write(String key, value) async {}
}
