import 'beize/helpers/http.dart';

export 'beize/helpers/http.dart' show TenkaRuntimeHttpClientOptions;

class TenkaRuntimeOptions {
  const TenkaRuntimeOptions({
    required this.http,
  });

  final TenkaRuntimeHttpClientOptions http;
}
