import 'package:meta/meta.dart';
import 'webview.dart';

class WebviewProviderOptions {
  const WebviewProviderOptions({
    final this.localChromiumPath,
    final this.devMode = false,
  });

  final String? localChromiumPath;
  final bool devMode;
}

abstract class WebviewProvider<T extends WebviewProvider<T>> {
  bool ready = false;
  bool disposed = false;

  @mustCallSuper
  Future<void> initialize(final WebviewProviderOptions options) async {
    ready = true;
  }

  Future<Webview<T>> create();

  @mustCallSuper
  Future<void> dispose() async {
    disposed = true;
  }
}
