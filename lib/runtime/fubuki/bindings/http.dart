import 'dart:io';
import 'package:fubuki_vm/fubuki_vm.dart';
import 'package:http/http.dart' as http;
import '../helpers/http.dart';

abstract class HttpBindings {
  static const Duration timeout = Duration(seconds: 15);

  static const String userAgentWindows =
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36';
  static const String userAgentLinux =
      'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.157 Safari/537.36';
  static const String userAgentMacOS =
      'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/11.1.2 Safari/605.1.15';

  static void bind(final FubukiNamespace namespace) {
    final FubukiObjectValue value = FubukiObjectValue();
    value.set(
      FubukiStringValue('request'),
      FubukiNativeFunctionValue.asyncReturn(
        (final FubukiNativeFunctionCall call) async {
          final FubukiObjectValue options = call.argumentAt(0);
          final FubukiStringValue method =
              options.get(FubukiStringValue('method')).cast();
          final FubukiStringValue url =
              options.get(FubukiStringValue('url')).cast();
          final FubukiValue body = options.get(FubukiStringValue('body'));
          final FubukiValue headers = options.get(FubukiStringValue('headers'));

          final Uri uri = Uri.parse(url.value);
          final String? bodyStr = body is FubukiStringValue ? body.value : null;
          final Map<String, String> headersMap = <String, String>{};
          if (headers is FubukiObjectValue) {
            for (final MapEntry<FubukiValue, FubukiValue> x
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
              throw FubukiExceptionNatives.newExceptionNative(
                'Invalid http method "${method.value}"',
                call.vm.getCurrentStackTrace(),
              );
          }

          return newHttpResponse(response);
        },
      ),
    );
    value.set(
      FubukiStringValue('defaultDesktopUserAgent'),
      FubukiNativeFunctionValue.sync(
        (final _) => FubukiStringValue(defaultDesktopUserAgent),
      ),
    );
    namespace.declare('Http', value);
  }

  static FubukiValue newHttpResponse(final http.Response response) {
    final FubukiObjectValue value = FubukiObjectValue();
    value.set(
      FubukiStringValue('body'),
      FubukiStringValue(response.body),
    );
    final FubukiObjectValue headers = FubukiObjectValue();
    for (final MapEntry<String, String> x in response.headers.entries) {
      headers.set(FubukiStringValue(x.key), FubukiStringValue(x.value));
    }
    value.set(FubukiStringValue('headers'), headers);
    value.set(
      FubukiStringValue('statusCode'),
      FubukiNumberValue(response.statusCode.toDouble()),
    );
    value.set(
      FubukiStringValue('reasonPhrase'),
      response.reasonPhrase != null
          ? FubukiStringValue(response.reasonPhrase!)
          : FubukiNullValue.value,
    );
    value.set(
      FubukiStringValue('isRedirect'),
      FubukiBooleanValue(response.isRedirect),
    );
    return value;
  }

  static String get defaultDesktopUserAgent {
    if (Platform.isWindows) return userAgentWindows;
    if (Platform.isMacOS) return userAgentMacOS;
    return userAgentLinux;
  }
}