import 'package:tenka/tenka.dart';
import 'package:utilx_desktop/webview/puppeteer/provider.dart';
import 'utils/benchmark.dart';

abstract class TenkaDevEnvironment {
  static Future<void> prepare() async {
    await TenkaInternals.initialize(
      runtime: TenkaRuntimeOptions(
        http: const TenkaRuntimeHttpClientOptions(ignoreSSLCertificate: true),
        webview: WebviewManagerInitializeOptions(
          PuppeteerProvider(),
          const WebviewProviderOptions(),
        ),
      ),
    );
  }

  static Future<void> dispose() async {
    await TenkaInternals.dispose();
  }

  static Future<void> middleware(final VoidFutureCallback fn) async {
    await prepare();
    await fn();
    await dispose();
  }
}
