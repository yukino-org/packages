import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:utilx/utils.dart';
import '../../helpers/http.dart';
import 'result/class.dart';

enum HttpMethods {
  get,
  post,
  head,
  patch,
  delete,
  put,
}

extension HttpMethodsUtils on HttpMethods {
  Future<http.Response> send({
    required final Uri uri,
    required final Map<String, String> headers,
    required final Duration timeout,
    final String? body,
  }) {
    switch (this) {
      case HttpMethods.get:
        return TenkaRuntimeHttpClient.client
            .get(uri, headers: headers)
            .timeout(timeout);

      case HttpMethods.post:
        return TenkaRuntimeHttpClient.client
            .post(uri, body: body, headers: headers)
            .timeout(timeout);

      case HttpMethods.head:
        return TenkaRuntimeHttpClient.client
            .head(uri, headers: headers)
            .timeout(timeout);

      case HttpMethods.patch:
        return TenkaRuntimeHttpClient.client
            .patch(uri, body: body, headers: headers)
            .timeout(timeout);

      case HttpMethods.delete:
        return TenkaRuntimeHttpClient.client
            .delete(uri, body: body, headers: headers)
            .timeout(timeout);

      case HttpMethods.put:
        return TenkaRuntimeHttpClient.client
            .put(uri, body: body, headers: headers)
            .timeout(timeout);
    }
  }
}

class Http {
  static const Duration timeout = Duration(seconds: 10);
  static const Duration extendedTimeout = Duration(seconds: 20);

  static Future<HttpResponse> fetch({
    required final String method,
    required final String url,
    final Map<String, String>? headers,
    final String? body,
  }) async {
    final Uri uri = Uri.parse(url);

    final Map<String, String> castedHeaders =
        headers?.cast<String, String>() ?? <String, String>{};

    final HttpMethods? parsedMethod =
        EnumUtils.findOrNull(HttpMethods.values, method.toLowerCase());
    if (parsedMethod == null) throw Exception('Invalid method: $method');

    final http.Response res = await parsedMethod.send(
      uri: uri,
      headers: castedHeaders,
      timeout: timeout,
      body: body,
    );

    return HttpResponse(
      body: res.body,
      headers: res.headers,
      statusCode: res.statusCode,
    );
  }

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
