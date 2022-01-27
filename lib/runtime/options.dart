import 'package:utilx/utilities/webview/webview.dart';
import './hetu/helpers/http.dart';

export 'package:utilx/utilities/webview/webview.dart'
    show WebviewProviderOptions;
export './hetu/helpers/http.dart' show HttpClientOptions;

class ERuntimeOptions {
  const ERuntimeOptions({
    required final this.http,
    required final this.webview,
  });

  final HttpClientOptions http;
  final WebviewProviderOptions webview;
}
