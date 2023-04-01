import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_app/services/storage_service/flutter_secure_storage_storage_service.dart';
import 'package:flutter_test_app/services/storage_service/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final StorageService<String> storageService =
      FlutterSecureStorageStorageService();

  const testKey = 'key';
  const testValue = 'value';

  FlutterSecureStorage.setMockInitialValues({testKey: testValue});

  test('Should read data', () async {
    expect(await storageService.read(testKey), testValue);
  });

  test('Should store data', () async {
    const newKey = 'key2';
    const newValue = 'value2';

    expect(await storageService.read(newKey), null);

    await storageService.write(newKey, newValue);

    expect(await storageService.read(newKey), newValue);
  });

  test('Should remove data', () async {
    await storageService.remove(testKey);

    expect(await storageService.read(testKey), null);
  });

  test('Should clear data', () async {
    const newKey = 'key2';
    const newValue = 'value2';
    const newKey2 = 'key3';
    const newValue2 = 'value3';

    await storageService.write(newKey, newValue);
    await storageService.write(newKey2, newValue2);

    await storageService.clear();

    expect(await storageService.read(testKey), null);
    expect(await storageService.read(newKey), null);
    expect(await storageService.read(newKey2), null);
  });
}
