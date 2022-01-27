import 'package:extensions/extensions.dart';
import '../utils/console.dart';

abstract class TEnvironment {
  static Future<void> prepare() async {
    await ExtensionInternals.initialize(
      runtime: const ERuntimeOptions(
        http: HttpClientOptions(ignoreSSLCertificate: true),
        webview: WebviewProviderOptions(),
      ),
    );
  }

  static Future<void> runTests(
    final Map<String, Future<void> Function()> tests, {
    final bool parseEnvironmentMethod = true,
  }) async {
    final String? envMethods =
        parseEnvironmentMethod && const bool.hasEnvironment('method')
            ? const String.fromEnvironment('method')
            : null;

    final List<String> methods = envMethods?.split(',') ?? tests.keys.toList();

    for (final String method in methods) {
      if (tests.containsKey(method)) {
        try {
          TConsole.p('Testing: ${Colorize('$method()').cyan()}');
          TConsole.ln();
          await tests[method]!();
          TConsole.p('Passed: ${Colorize('$method()').cyan()}');
        } catch (err, stack) {
          TConsole.err(err, stack);
          TConsole.p('Failed: ${Colorize('$method()').cyan()}');
        }

        TConsole.ln();
      }
    }
  }

  static Future<void> dispose() async {
    await ExtensionInternals.dispose();
  }
}
