abstract class TypeUtils {
  static Map<dynamic, dynamic> castAsMap(final dynamic data) =>
      data as Map<dynamic, dynamic>;

  static Map<K, V> castAsTypedMap<K, V>(final dynamic data) =>
      castAsMap(data).cast<K, V>();

  static List<dynamic> castAsList(final dynamic data) => data as List<dynamic>;

  static List<T> castAsTypedList<T>(final dynamic data) =>
      castAsList(data).cast<T>();
}
