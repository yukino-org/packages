import 'dart:io';
import 'package:beize_vm/beize_vm.dart';
import 'package:http/http.dart' as http;
import '../converter/exports.dart';
import '../helpers/http.dart';

abstract class HttpBindings {
  static const Duration timeout = Duration(seconds: 15);

  static const String userAgentWindows =
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36';
  static const String userAgentLinux =
      'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.157 Safari/537.36';
  static const String userAgentMacOS =
      'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/11.1.2 Safari/605.1.15';

  static void bind(final BeizeNamespace namespace) {
    final BeizeObjectValue value = BeizeObjectValue();
    value.setNamedProperty(
      'request',
      BeizeNativeFunctionValue.async(
        (final BeizeNativeFunctionCall call) async {
          final BeizeObjectValue options = call.argumentAt(0);
          final BeizeStringValue method = options.getNamedProperty('method');
          final BeizeStringValue url = options.getNamedProperty('url');
          final BeizeValue body = options.getNamedProperty('body');
          final BeizeValue headers = options.getNamedProperty('headers');

          final Uri uri = Uri.parse(url.value);
          final String? bodyStr = body is BeizeStringValue ? body.value : null;
          final Map<String, String> headersMap = <String, String>{};
          if (headers is BeizeObjectValue) {
            for (final MapEntry<BeizeValue, BeizeValue> x
                in headers.entries()) {
              headersMap[x.key.kToString()] = x.value.kToString();
            }
          }

          final http.Response response;
          switch (method.value.toLowerCase()) {
            case 'get':
              response = await TenkaRuntimeHttpClient.client
                  .get(uri, headers: headersMap)
                  .timeout(timeout);
              break;

            case 'post':
              response = await TenkaRuntimeHttpClient.client
                  .post(uri, body: bodyStr, headers: headersMap)
                  .timeout(timeout);
              break;

            case 'head':
              response = await TenkaRuntimeHttpClient.client
                  .head(uri, headers: headersMap)
                  .timeout(timeout);
              break;

            case 'patch':
              response = await TenkaRuntimeHttpClient.client
                  .patch(uri, body: bodyStr, headers: headersMap)
                  .timeout(timeout);
              break;

            case 'delete':
              response = await TenkaRuntimeHttpClient.client
                  .delete(uri, body: bodyStr, headers: headersMap)
                  .timeout(timeout);
              break;

            case 'put':
              response = await TenkaRuntimeHttpClient.client
                  .put(uri, body: bodyStr, headers: headersMap)
                  .timeout(timeout);
              break;

            default:
              throw Exception('Invalid http method "${method.value}"');
          }

          return newHttpResponse(response);
        },
      ),
    );
    value.setNamedProperty(
      'defaultDesktopUserAgent',
      BeizeNativeFunctionValue.sync(
        (final _) => BeizeStringValue(defaultDesktopUserAgent),
      ),
    );
    namespace.declare('Http', value);
  }

  static BeizeValue newHttpResponse(final http.Response response) {
    final BeizeObjectValue value = BeizeObjectValue();
    value.setNamedProperty(
      'body',
      BeizeStringValue(response.body),
    );
    final BeizeObjectValue headers = BeizeObjectValue();
    for (final MapEntry<String, String> x in response.headers.entries) {
      headers.setNamedProperty(x.key, BeizeStringValue(x.value));
    }
    value.setNamedProperty('headers', headers);
    value.setNamedProperty(
      'statusCode',
      BeizeNumberValue(response.statusCode.toDouble()),
    );
    value.setNamedProperty(
      'reasonPhrase',
      response.reasonPhrase != null
          ? BeizeStringValue(response.reasonPhrase!)
          : BeizeNullValue.value,
    );
    value.setNamedProperty(
      'isRedirect',
      BeizeBooleanValue(response.isRedirect),
    );
    return value;
  }

  static String get defaultDesktopUserAgent {
    if (Platform.isWindows) return userAgentWindows;
    if (Platform.isMacOS) return userAgentMacOS;
    return userAgentLinux;
  }
}
