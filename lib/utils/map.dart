abstract class MapUtils {
  static T get<T>(
    final Map<dynamic, dynamic> data,
    final List<dynamic> keys,
  ) {
    dynamic local = data;
    for (final dynamic x in keys) {
      if (local is! Map<dynamic, dynamic>) {
        throw Exception(
          'Could not get key "$x" (Previous value was not a map)',
        );
      }

      if (!local.containsKey(x)) {
        throw Exception(
          'Could not get key "$x" (Previous value does not contain this key)',
        );
      }

      local = local[x];
    }
    return local as T;
  }

  static T? maybeGet<T>(
    final Map<dynamic, dynamic> data,
    final List<dynamic> keys,
  ) {
    dynamic local = data;
    for (final dynamic x in keys) {
      if (local is! Map<dynamic, dynamic>) {
        throw Exception(
          'Could not get key "$x" (Previous value was not a map)',
        );
      }

      if (!local.containsKey(x)) {
        return null;
      }

      local = local[x];
    }
    return local as T;
  }
}
