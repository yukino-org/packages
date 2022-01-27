import 'dart:io';
import 'package:http/http.dart';
import './result/class.dart';
import '../../helpers/http.dart';

class Http {
  static const Duration timeout = Duration(seconds: 10);
  static const Duration extendedTimeout = Duration(seconds: 20);

  static Future<HttpResponse> fetch({
    required final String method,
    required final String url,
    final Map<String, String>? headers,
    final String? body,
  }) async {
    final String encodedURL = tryEncodeURL(url);

    final Map<String, String> castedHeaders =
        headers?.cast<String, String>() ?? <String, String>{};

    final Response res;
    switch (method) {
      case 'get':
        res = await HetuHttpClient.client
            .get(Uri.parse(encodedURL), headers: castedHeaders)
            .timeout(timeout);
        break;

      case 'post':
        res = await HetuHttpClient.client
            .post(Uri.parse(encodedURL), body: body, headers: castedHeaders)
            .timeout(timeout);
        break;

      case 'head':
        res = await HetuHttpClient.client
            .head(Uri.parse(encodedURL), headers: castedHeaders)
            .timeout(timeout);
        break;

      case 'patch':
        res = await HetuHttpClient.client
            .patch(Uri.parse(encodedURL), body: body, headers: castedHeaders)
            .timeout(timeout);
        break;

      case 'delete':
        res = await HetuHttpClient.client
            .delete(Uri.parse(encodedURL), body: body, headers: castedHeaders)
            .timeout(timeout);
        break;

      case 'put':
        res = await HetuHttpClient.client
            .put(Uri.parse(encodedURL), body: body, headers: castedHeaders)
            .timeout(timeout);
        break;

      default:
        throw AssertionError('Unknown "method": $method');
    }

    return HttpResponse(
      body: res.body,
      headers: res.headers,
      statusCode: res.statusCode,
    );
  }

  static String tryEncodeURL(final String url) {
    try {
      if (url != Uri.decodeFull(url)) return url;
    } catch (_) {}

    return Uri.encodeFull(url);
  }

  static String ensureProtocol(
    final String url, {
    final bool https = true,
  }) =>
      !url.startsWith('http')
          ? https
              ? 'https:$url'
              : 'http:$url'
          : url;

  static String ensureURL(final String url) =>
      tryEncodeURL(ensureProtocol(url));

  static const String userAgentWindows =
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36';
  static const String userAgentLinux =
      'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.157 Safari/537.36';
  static const String userAgentMacOS =
      'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/11.1.2 Safari/605.1.15';

  static String get defaultUserAgent => Platform.isWindows
      ? userAgentWindows
      : Platform.isMacOS
          ? userAgentMacOS
          : userAgentLinux;
}
