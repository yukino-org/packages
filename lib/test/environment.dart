import 'package:extensions/extensions.dart';
import 'package:test/test.dart';

abstract class TEnvironment {
  static Future<void> prepare() async {
    await ExtensionInternals.initialize(
      runtime: const ERuntimeOptions(
        http: HttpClientOptions(ignoreSSLCertificate: true),
        webview: WebviewProviderOptions(),
      ),
    );
  }

  static void runTests(
    final Map<String, Future<void> Function()> tests, {
    final bool parseEnvironmentMethod = true,
  }) {
    final String? envMethods =
        parseEnvironmentMethod && const bool.hasEnvironment('method')
            ? const String.fromEnvironment('method')
            : null;

    final List<String> methods = envMethods?.split(',') ?? tests.keys.toList();

    for (final String method in methods) {
      if (tests.containsKey(method)) {
        test(method, tests[methods]!);
      }
    }
  }

  static Future<void> dispose() async {
    await ExtensionInternals.dispose();
  }
}
