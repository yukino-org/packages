import 'baize/helpers/http.dart';

export 'baize/helpers/http.dart' show TenkaRuntimeHttpClientOptions;

class TenkaRuntimeOptions {
  const TenkaRuntimeOptions({
    required this.http,
  });

  final TenkaRuntimeHttpClientOptions http;
}
