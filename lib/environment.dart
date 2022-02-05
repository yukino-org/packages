import 'package:extensions/extensions.dart';
import 'package:extensions/runtime.dart';

abstract class DTEnvironment {
  static Future<void> prepare() async {
    await ExtensionInternals.initialize(
      runtime: const ERuntimeOptions(
        http: HttpClientOptions(ignoreSSLCertificate: true),
        webview: WebviewProviderOptions(),
      ),
    );
  }

  static Future<void> dispose() async {
    await ExtensionInternals.dispose();
  }
}
