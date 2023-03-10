extension IterableHandling<K> on Iterable<K> {
  List<T> mapList<T>(
    T Function(K) toElement, {
    bool growable = true,
  }) {
    return map(toElement).toList(growable: growable);
  }
}
