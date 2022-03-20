abstract class MapUtils {
  static T get<T>(
    final Map<dynamic, dynamic> data,
    final List<dynamic> keys,
  ) {
    dynamic local = data;
    for (final dynamic x in keys) {
      try {
        local = (local as Map<dynamic, dynamic>)[x];
      } catch (err) {
        throw Exception('Could not get key "$x" ($err)');
      }
    }
    return local as T;
  }
}
