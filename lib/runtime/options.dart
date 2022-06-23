import 'hetu/helpers/http.dart';

export 'hetu/helpers/http.dart' show TenkaRuntimeHttpClientOptions;

class TenkaRuntimeOptions {
  const TenkaRuntimeOptions({
    required final this.http,
  });

  final TenkaRuntimeHttpClientOptions http;
}
