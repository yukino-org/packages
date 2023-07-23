import 'package:beize_vm/beize_vm.dart';
import '../converter/exports.dart';

abstract class UrlBindings {
  static void bind(final BeizeNamespace namespace) {
    final BeizeObjectValue value = BeizeObjectValue();
    value.setNamedProperty(
      'parse',
      BeizeNativeFunctionValue.sync(
        (final BeizeNativeFunctionCall call) {
          final String url = call.argumentAt<BeizeStringValue>(0).value;
          return newUrl(Uri.parse(url));
        },
      ),
    );
    value.setNamedProperty(
      'ensureHttpScheme',
      BeizeNativeFunctionValue.sync(
        (final BeizeNativeFunctionCall call) {
          final String url = call.argumentAt<BeizeStringValue>(0).value;
          return BeizeStringValue(
            !url.startsWith('http:') ? 'http:$url' : url,
          );
        },
      ),
    );
    value.setNamedProperty(
      'ensureHttpsScheme',
      BeizeNativeFunctionValue.sync(
        (final BeizeNativeFunctionCall call) {
          final String url = call.argumentAt<BeizeStringValue>(0).value;
          return BeizeStringValue(
            !url.startsWith('https:') ? 'https:$url' : url,
          );
        },
      ),
    );
    value.setNamedProperty(
      'ensure',
      BeizeNativeFunctionValue.sync(
        (final BeizeNativeFunctionCall call) {
          String url = call.argumentAt<BeizeStringValue>(0).value;
          if (!url.startsWith(RegExp('https?:'))) {
            url = 'https:$url';
          }
          try {
            if (url != Uri.decodeFull(url)) return BeizeStringValue(url);
          } catch (_) {}
          return BeizeStringValue(Uri.encodeFull(url));
        },
      ),
    );
    value.setNamedProperty(
      'encodeComponent',
      BeizeNativeFunctionValue.sync(
        (final BeizeNativeFunctionCall call) {
          final String query = call.argumentAt<BeizeStringValue>(0).value;
          return BeizeStringValue(Uri.encodeComponent(query));
        },
      ),
    );
    value.setNamedProperty(
      'decodeComponent',
      BeizeNativeFunctionValue.sync(
        (final BeizeNativeFunctionCall call) {
          final String query = call.argumentAt<BeizeStringValue>(0).value;
          return BeizeStringValue(Uri.decodeComponent(query));
        },
      ),
    );
    value.setNamedProperty(
      'encodeQueryComponent',
      BeizeNativeFunctionValue.sync(
        (final BeizeNativeFunctionCall call) {
          final String query = call.argumentAt<BeizeStringValue>(0).value;
          return BeizeStringValue(Uri.encodeQueryComponent(query));
        },
      ),
    );
    value.setNamedProperty(
      'decodeQueryComponent',
      BeizeNativeFunctionValue.sync(
        (final BeizeNativeFunctionCall call) {
          final String query = call.argumentAt<BeizeStringValue>(0).value;
          return BeizeStringValue(Uri.decodeQueryComponent(query));
        },
      ),
    );
    value.setNamedProperty(
      'splitQueryString',
      BeizeNativeFunctionValue.sync(
        (final BeizeNativeFunctionCall call) {
          final BeizeStringValue value = call.argumentAt(0);
          return convertQueryParametersToValue(
            Uri.splitQueryString(value.value),
          );
        },
      ),
    );
    value.setNamedProperty(
      'joinQueryString',
      BeizeNativeFunctionValue.sync(
        (final BeizeNativeFunctionCall call) {
          final BeizeObjectValue queries = call.argumentAt(0);
          final Map<String, String> queriesMap = <String, String>{};
          for (final MapEntry<BeizeValue, BeizeValue> x in queries.entries()) {
            queriesMap[x.key.kToString()] = x.value.kToString();
          }
          return BeizeStringValue(Uri(queryParameters: queriesMap).query);
        },
      ),
    );
    namespace.declare('Url', value);
  }

  static BeizeValue newUrl(final Uri url) {
    final BeizeObjectValue value = BeizeObjectValue();
    value.setNamedProperty(
      'authority',
      BeizeStringValue(url.authority),
    );
    value.setNamedProperty(
      'fragment',
      BeizeStringValue(url.fragment),
    );
    value.setNamedProperty(
      'host',
      BeizeStringValue(url.host),
    );
    value.setNamedProperty(
      'origin',
      BeizeStringValue(url.origin),
    );
    value.setNamedProperty(
      'path',
      BeizeStringValue(url.path),
    );
    value.setNamedProperty(
      'port',
      BeizeNumberValue(url.port.toDouble()),
    );
    value.setNamedProperty(
      'query',
      BeizeStringValue(url.query),
    );
    value.setNamedProperty(
      'scheme',
      BeizeStringValue(url.scheme),
    );
    value.setNamedProperty(
      'hasAbsolutePath',
      BeizeNativeFunctionValue.sync(
        (final _) => BeizeBooleanValue(url.hasAbsolutePath),
      ),
    );
    value.setNamedProperty(
      'hasAuthority',
      BeizeNativeFunctionValue.sync(
        (final _) => BeizeBooleanValue(url.hasAuthority),
      ),
    );
    value.setNamedProperty(
      'hasEmptyPath',
      BeizeNativeFunctionValue.sync(
        (final _) => BeizeBooleanValue(url.hasEmptyPath),
      ),
    );
    value.setNamedProperty(
      'hasFragment',
      BeizeNativeFunctionValue.sync(
        (final _) => BeizeBooleanValue(url.hasFragment),
      ),
    );
    value.setNamedProperty(
      'hasPort',
      BeizeNativeFunctionValue.sync(
        (final _) => BeizeBooleanValue(url.hasPort),
      ),
    );
    value.setNamedProperty(
      'hasQuery',
      BeizeNativeFunctionValue.sync(
        (final _) => BeizeBooleanValue(url.hasQuery),
      ),
    );
    value.setNamedProperty(
      'hasScheme',
      BeizeNativeFunctionValue.sync(
        (final _) => BeizeBooleanValue(url.hasScheme),
      ),
    );
    value.setNamedProperty(
      'isAbsolute',
      BeizeNativeFunctionValue.sync(
        (final _) => BeizeBooleanValue(url.isAbsolute),
      ),
    );
    value.setNamedProperty(
      'pathSegments',
      BeizeNativeFunctionValue.sync(
        (final _) => BeizeListValue(
          url.pathSegments
              .map((final String x) => BeizeStringValue(x))
              .toList(),
        ),
      ),
    );
    value.setNamedProperty(
      'queryParameters',
      BeizeNativeFunctionValue.sync(
        (final _) => convertQueryParametersToValue(url.queryParameters),
      ),
    );
    return value;
  }

  static BeizeValue convertQueryParametersToValue(
    final Map<String, String> queryParameters,
  ) {
    final BeizeObjectValue queries = BeizeObjectValue();
    for (final MapEntry<String, String> x in queryParameters.entries) {
      queries.setNamedProperty(x.key, BeizeStringValue(x.value));
    }
    return queries;
  }
}
