/// Base class for storage services
abstract class StorageService<T> {
  /// Write [value] to storage with [key].
  Future<void> write(String key, T value);

  /// Read the value assigned to [key].
  Future<T?> read(String key);

  /// Remove the value assigned to [key].
  Future<void> remove(String key);

  /// Clear all written values.
  Future<void> clear();
}
