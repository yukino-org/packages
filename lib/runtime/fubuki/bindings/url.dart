import 'package:fubuki_vm/fubuki_vm.dart';

abstract class UrlBindings {
  static void bind(final FubukiNamespace namespace) {
    final FubukiObjectValue value = FubukiObjectValue();
    value.set(
      FubukiStringValue('ensureHttpScheme'),
      FubukiNativeFunctionValue.sync(
        (final FubukiNativeFunctionCall call) {
          final String url = call.argumentAt<FubukiStringValue>(0).value;
          return FubukiStringValue(
            !url.startsWith('http:') ? 'http:$url' : url,
          );
        },
      ),
    );
    value.set(
      FubukiStringValue('ensureHttpsScheme'),
      FubukiNativeFunctionValue.sync(
        (final FubukiNativeFunctionCall call) {
          final String url = call.argumentAt<FubukiStringValue>(0).value;
          return FubukiStringValue(
            !url.startsWith('https:') ? 'https:$url' : url,
          );
        },
      ),
    );
    value.set(
      FubukiStringValue('ensure'),
      FubukiNativeFunctionValue.sync(
        (final FubukiNativeFunctionCall call) {
          final String url = call.argumentAt<FubukiStringValue>(0).value;
          try {
            if (url != Uri.decodeFull(url)) return FubukiStringValue(url);
          } catch (_) {}
          return FubukiStringValue(Uri.encodeFull(url));
        },
      ),
    );
    value.set(
      FubukiStringValue('encodeComponent'),
      FubukiNativeFunctionValue.sync(
        (final FubukiNativeFunctionCall call) {
          final String query = call.argumentAt<FubukiStringValue>(0).value;
          return FubukiStringValue(Uri.encodeComponent(query));
        },
      ),
    );
    value.set(
      FubukiStringValue('decodeComponent'),
      FubukiNativeFunctionValue.sync(
        (final FubukiNativeFunctionCall call) {
          final String query = call.argumentAt<FubukiStringValue>(0).value;
          return FubukiStringValue(Uri.decodeComponent(query));
        },
      ),
    );
    value.set(
      FubukiStringValue('encodeQueryComponent'),
      FubukiNativeFunctionValue.sync(
        (final FubukiNativeFunctionCall call) {
          final String query = call.argumentAt<FubukiStringValue>(0).value;
          return FubukiStringValue(Uri.encodeQueryComponent(query));
        },
      ),
    );
    value.set(
      FubukiStringValue('decodeQueryComponent'),
      FubukiNativeFunctionValue.sync(
        (final FubukiNativeFunctionCall call) {
          final String query = call.argumentAt<FubukiStringValue>(0).value;
          return FubukiStringValue(Uri.decodeQueryComponent(query));
        },
      ),
    );
    value.set(
      FubukiStringValue('splitQueryString'),
      FubukiNativeFunctionValue.sync(
        (final FubukiNativeFunctionCall call) {
          final String query = call.argumentAt<FubukiStringValue>(0).value;
          final FubukiObjectValue queries = FubukiObjectValue();
          for (final MapEntry<String, String> x
              in Uri.splitQueryString(query).entries) {
            queries.set(FubukiStringValue(x.key), FubukiStringValue(x.value));
          }
          return queries;
        },
      ),
    );
    value.set(
      FubukiStringValue('joinQueryString'),
      FubukiNativeFunctionValue.sync(
        (final FubukiNativeFunctionCall call) {
          final FubukiObjectValue queries = call.argumentAt(0);
          final Map<String, String> queriesMap = <String, String>{};
          for (final MapEntry<FubukiValue, FubukiValue> x
              in queries.entries()) {
            queriesMap[x.key.kToString()] = x.value.kToString();
          }
          return FubukiStringValue(Uri(queryParameters: queriesMap).query);
        },
      ),
    );
    namespace.declare('Url', value);
  }
}
