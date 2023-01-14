import 'fubuki/helpers/http.dart';

export 'fubuki/helpers/http.dart' show TenkaRuntimeHttpClientOptions;

class TenkaRuntimeOptions {
  const TenkaRuntimeOptions({
    required this.http,
  });

  final TenkaRuntimeHttpClientOptions http;
}
