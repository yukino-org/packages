import 'package:fubuki_vm/fubuki_vm.dart';
import '../converter/exports.dart';

abstract class UrlBindings {
  static void bind(final FubukiNamespace namespace) {
    final FubukiObjectValue value = FubukiObjectValue();
    value.setNamedProperty(
      'parse',
      FubukiNativeFunctionValue.sync(
        (final FubukiNativeFunctionCall call) {
          final String url = call.argumentAt<FubukiStringValue>(0).value;
          return newUrl(Uri.parse(url));
        },
      ),
    );
    value.setNamedProperty(
      'ensureHttpScheme',
      FubukiNativeFunctionValue.sync(
        (final FubukiNativeFunctionCall call) {
          final String url = call.argumentAt<FubukiStringValue>(0).value;
          return FubukiStringValue(
            !url.startsWith('http:') ? 'http:$url' : url,
          );
        },
      ),
    );
    value.setNamedProperty(
      'ensureHttpsScheme',
      FubukiNativeFunctionValue.sync(
        (final FubukiNativeFunctionCall call) {
          final String url = call.argumentAt<FubukiStringValue>(0).value;
          return FubukiStringValue(
            !url.startsWith('https:') ? 'https:$url' : url,
          );
        },
      ),
    );
    value.setNamedProperty(
      'ensure',
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
    value.setNamedProperty(
      'encodeComponent',
      FubukiNativeFunctionValue.sync(
        (final FubukiNativeFunctionCall call) {
          final String query = call.argumentAt<FubukiStringValue>(0).value;
          return FubukiStringValue(Uri.encodeComponent(query));
        },
      ),
    );
    value.setNamedProperty(
      'decodeComponent',
      FubukiNativeFunctionValue.sync(
        (final FubukiNativeFunctionCall call) {
          final String query = call.argumentAt<FubukiStringValue>(0).value;
          return FubukiStringValue(Uri.decodeComponent(query));
        },
      ),
    );
    value.setNamedProperty(
      'encodeQueryComponent',
      FubukiNativeFunctionValue.sync(
        (final FubukiNativeFunctionCall call) {
          final String query = call.argumentAt<FubukiStringValue>(0).value;
          return FubukiStringValue(Uri.encodeQueryComponent(query));
        },
      ),
    );
    value.setNamedProperty(
      'decodeQueryComponent',
      FubukiNativeFunctionValue.sync(
        (final FubukiNativeFunctionCall call) {
          final String query = call.argumentAt<FubukiStringValue>(0).value;
          return FubukiStringValue(Uri.decodeQueryComponent(query));
        },
      ),
    );
    value.setNamedProperty(
      'splitQueryString',
      FubukiNativeFunctionValue.sync(
        (final FubukiNativeFunctionCall call) {
          final FubukiStringValue value = call.argumentAt(0);
          return convertQueryParametersToValue(
            Uri.splitQueryString(value.value),
          );
        },
      ),
    );
    value.setNamedProperty(
      'joinQueryString',
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

  static FubukiValue newUrl(final Uri url) {
    final FubukiObjectValue value = FubukiObjectValue();
    value.setNamedProperty(
      'authority',
      FubukiStringValue(url.authority),
    );
    value.setNamedProperty(
      'fragment',
      FubukiStringValue(url.fragment),
    );
    value.setNamedProperty(
      'host',
      FubukiStringValue(url.host),
    );
    value.setNamedProperty(
      'origin',
      FubukiStringValue(url.origin),
    );
    value.setNamedProperty(
      'path',
      FubukiStringValue(url.path),
    );
    value.setNamedProperty(
      'port',
      FubukiNumberValue(url.port.toDouble()),
    );
    value.setNamedProperty(
      'query',
      FubukiStringValue(url.query),
    );
    value.setNamedProperty(
      'scheme',
      FubukiStringValue(url.scheme),
    );
    value.setNamedProperty(
      'hasAbsolutePath',
      FubukiNativeFunctionValue.sync(
        (final _) => FubukiBooleanValue(url.hasAbsolutePath),
      ),
    );
    value.setNamedProperty(
      'hasAuthority',
      FubukiNativeFunctionValue.sync(
        (final _) => FubukiBooleanValue(url.hasAuthority),
      ),
    );
    value.setNamedProperty(
      'hasEmptyPath',
      FubukiNativeFunctionValue.sync(
        (final _) => FubukiBooleanValue(url.hasEmptyPath),
      ),
    );
    value.setNamedProperty(
      'hasFragment',
      FubukiNativeFunctionValue.sync(
        (final _) => FubukiBooleanValue(url.hasFragment),
      ),
    );
    value.setNamedProperty(
      'hasPort',
      FubukiNativeFunctionValue.sync(
        (final _) => FubukiBooleanValue(url.hasPort),
      ),
    );
    value.setNamedProperty(
      'hasQuery',
      FubukiNativeFunctionValue.sync(
        (final _) => FubukiBooleanValue(url.hasQuery),
      ),
    );
    value.setNamedProperty(
      'hasScheme',
      FubukiNativeFunctionValue.sync(
        (final _) => FubukiBooleanValue(url.hasScheme),
      ),
    );
    value.setNamedProperty(
      'isAbsolute',
      FubukiNativeFunctionValue.sync(
        (final _) => FubukiBooleanValue(url.isAbsolute),
      ),
    );
    value.setNamedProperty(
      'pathSegments',
      FubukiNativeFunctionValue.sync(
        (final _) => FubukiListValue(
          url.pathSegments
              .map((final String x) => FubukiStringValue(x))
              .toList(),
        ),
      ),
    );
    value.setNamedProperty(
      'queryParameters',
      FubukiNativeFunctionValue.sync(
        (final _) => convertQueryParametersToValue(url.queryParameters),
      ),
    );
    return value;
  }

  static FubukiValue convertQueryParametersToValue(
    final Map<String, String> queryParameters,
  ) {
    final FubukiObjectValue queries = FubukiObjectValue();
    for (final MapEntry<String, String> x in queryParameters.entries) {
      queries.setNamedProperty(x.key, FubukiStringValue(x.value));
    }
    return queries;
  }
}
