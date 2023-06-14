import 'package:baize_vm/baize_vm.dart';
import '../converter/exports.dart';

abstract class UrlBindings {
  static void bind(final BaizeNamespace namespace) {
    final BaizeObjectValue value = BaizeObjectValue();
    value.setNamedProperty(
      'parse',
      BaizeNativeFunctionValue.sync(
        (final BaizeNativeFunctionCall call) {
          final String url = call.argumentAt<BaizeStringValue>(0).value;
          return newUrl(Uri.parse(url));
        },
      ),
    );
    value.setNamedProperty(
      'ensureHttpScheme',
      BaizeNativeFunctionValue.sync(
        (final BaizeNativeFunctionCall call) {
          final String url = call.argumentAt<BaizeStringValue>(0).value;
          return BaizeStringValue(
            !url.startsWith('http:') ? 'http:$url' : url,
          );
        },
      ),
    );
    value.setNamedProperty(
      'ensureHttpsScheme',
      BaizeNativeFunctionValue.sync(
        (final BaizeNativeFunctionCall call) {
          final String url = call.argumentAt<BaizeStringValue>(0).value;
          return BaizeStringValue(
            !url.startsWith('https:') ? 'https:$url' : url,
          );
        },
      ),
    );
    value.setNamedProperty(
      'ensure',
      BaizeNativeFunctionValue.sync(
        (final BaizeNativeFunctionCall call) {
          String url = call.argumentAt<BaizeStringValue>(0).value;
          if (!url.startsWith(RegExp('https?:'))) {
            url = 'https:$url';
          }
          try {
            if (url != Uri.decodeFull(url)) return BaizeStringValue(url);
          } catch (_) {}
          return BaizeStringValue(Uri.encodeFull(url));
        },
      ),
    );
    value.setNamedProperty(
      'encodeComponent',
      BaizeNativeFunctionValue.sync(
        (final BaizeNativeFunctionCall call) {
          final String query = call.argumentAt<BaizeStringValue>(0).value;
          return BaizeStringValue(Uri.encodeComponent(query));
        },
      ),
    );
    value.setNamedProperty(
      'decodeComponent',
      BaizeNativeFunctionValue.sync(
        (final BaizeNativeFunctionCall call) {
          final String query = call.argumentAt<BaizeStringValue>(0).value;
          return BaizeStringValue(Uri.decodeComponent(query));
        },
      ),
    );
    value.setNamedProperty(
      'encodeQueryComponent',
      BaizeNativeFunctionValue.sync(
        (final BaizeNativeFunctionCall call) {
          final String query = call.argumentAt<BaizeStringValue>(0).value;
          return BaizeStringValue(Uri.encodeQueryComponent(query));
        },
      ),
    );
    value.setNamedProperty(
      'decodeQueryComponent',
      BaizeNativeFunctionValue.sync(
        (final BaizeNativeFunctionCall call) {
          final String query = call.argumentAt<BaizeStringValue>(0).value;
          return BaizeStringValue(Uri.decodeQueryComponent(query));
        },
      ),
    );
    value.setNamedProperty(
      'splitQueryString',
      BaizeNativeFunctionValue.sync(
        (final BaizeNativeFunctionCall call) {
          final BaizeStringValue value = call.argumentAt(0);
          return convertQueryParametersToValue(
            Uri.splitQueryString(value.value),
          );
        },
      ),
    );
    value.setNamedProperty(
      'joinQueryString',
      BaizeNativeFunctionValue.sync(
        (final BaizeNativeFunctionCall call) {
          final BaizeObjectValue queries = call.argumentAt(0);
          final Map<String, String> queriesMap = <String, String>{};
          for (final MapEntry<BaizeValue, BaizeValue> x in queries.entries()) {
            queriesMap[x.key.kToString()] = x.value.kToString();
          }
          return BaizeStringValue(Uri(queryParameters: queriesMap).query);
        },
      ),
    );
    namespace.declare('Url', value);
  }

  static BaizeValue newUrl(final Uri url) {
    final BaizeObjectValue value = BaizeObjectValue();
    value.setNamedProperty(
      'authority',
      BaizeStringValue(url.authority),
    );
    value.setNamedProperty(
      'fragment',
      BaizeStringValue(url.fragment),
    );
    value.setNamedProperty(
      'host',
      BaizeStringValue(url.host),
    );
    value.setNamedProperty(
      'origin',
      BaizeStringValue(url.origin),
    );
    value.setNamedProperty(
      'path',
      BaizeStringValue(url.path),
    );
    value.setNamedProperty(
      'port',
      BaizeNumberValue(url.port.toDouble()),
    );
    value.setNamedProperty(
      'query',
      BaizeStringValue(url.query),
    );
    value.setNamedProperty(
      'scheme',
      BaizeStringValue(url.scheme),
    );
    value.setNamedProperty(
      'hasAbsolutePath',
      BaizeNativeFunctionValue.sync(
        (final _) => BaizeBooleanValue(url.hasAbsolutePath),
      ),
    );
    value.setNamedProperty(
      'hasAuthority',
      BaizeNativeFunctionValue.sync(
        (final _) => BaizeBooleanValue(url.hasAuthority),
      ),
    );
    value.setNamedProperty(
      'hasEmptyPath',
      BaizeNativeFunctionValue.sync(
        (final _) => BaizeBooleanValue(url.hasEmptyPath),
      ),
    );
    value.setNamedProperty(
      'hasFragment',
      BaizeNativeFunctionValue.sync(
        (final _) => BaizeBooleanValue(url.hasFragment),
      ),
    );
    value.setNamedProperty(
      'hasPort',
      BaizeNativeFunctionValue.sync(
        (final _) => BaizeBooleanValue(url.hasPort),
      ),
    );
    value.setNamedProperty(
      'hasQuery',
      BaizeNativeFunctionValue.sync(
        (final _) => BaizeBooleanValue(url.hasQuery),
      ),
    );
    value.setNamedProperty(
      'hasScheme',
      BaizeNativeFunctionValue.sync(
        (final _) => BaizeBooleanValue(url.hasScheme),
      ),
    );
    value.setNamedProperty(
      'isAbsolute',
      BaizeNativeFunctionValue.sync(
        (final _) => BaizeBooleanValue(url.isAbsolute),
      ),
    );
    value.setNamedProperty(
      'pathSegments',
      BaizeNativeFunctionValue.sync(
        (final _) => BaizeListValue(
          url.pathSegments
              .map((final String x) => BaizeStringValue(x))
              .toList(),
        ),
      ),
    );
    value.setNamedProperty(
      'queryParameters',
      BaizeNativeFunctionValue.sync(
        (final _) => convertQueryParametersToValue(url.queryParameters),
      ),
    );
    return value;
  }

  static BaizeValue convertQueryParametersToValue(
    final Map<String, String> queryParameters,
  ) {
    final BaizeObjectValue queries = BaizeObjectValue();
    for (final MapEntry<String, String> x in queryParameters.entries) {
      queries.setNamedProperty(x.key, BaizeStringValue(x.value));
    }
    return queries;
  }
}
