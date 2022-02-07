import 'package:extensions/extensions.dart';
import 'package:extensions/runtime.dart';
import 'package:utilx_desktop/utilities/webview/providers/puppeteer/provider.dart';
import '../utils/runner.dart';

abstract class DTEnvironment {
  static Future<void> prepare() async {
    await EInternals.initialize(
      runtime: ERuntimeOptions(
        http: const HttpClientOptions(ignoreSSLCertificate: true),
        webview: WebviewManagerInitializeOptions(
          PuppeteerProvider(),
          const WebviewProviderOptions(),
        ),
      ),
    );
  }

  static Future<void> dispose() async {
    await EInternals.dispose();
  }

  static Future<void> middleware(final VoidFutureCallback fn) async {
    await prepare();
    await fn();
    await dispose();
  }
}
