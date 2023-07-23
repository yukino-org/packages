import 'dart:io';
import 'package:http/http.dart';
import 'package:http/io_client.dart';

class TenkaRuntimeHttpClientOptions {
  const TenkaRuntimeHttpClientOptions({
    required this.ignoreSSLCertificate,
  });

  final bool ignoreSSLCertificate;
}

abstract class TenkaRuntimeHttpClient {
  static late Client client;
  static late TenkaRuntimeHttpClientOptions options;

  static void initialize(final TenkaRuntimeHttpClientOptions options) {
    final HttpClient client = HttpClient();

    if (options.ignoreSSLCertificate) {
      client.badCertificateCallback =
          (final X509Certificate cert, final String host, final int port) =>
              true;
    }

    TenkaRuntimeHttpClient.client = IOClient(client);
  }
}
