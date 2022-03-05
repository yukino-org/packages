import 'package:utilx/webview/webview.dart';
import 'hetu/helpers/http.dart';

export 'package:utilx/webview/webview.dart'
    show WebviewManagerInitializeOptions, WebviewProviderOptions;
export 'hetu/helpers/http.dart' show TenkaRuntimeHttpClientOptions;

class TenkaRuntimeOptions {
  const TenkaRuntimeOptions({
    required final this.http,
    required final this.webview,
  });

  final TenkaRuntimeHttpClientOptions http;
  final WebviewManagerInitializeOptions webview;
}
