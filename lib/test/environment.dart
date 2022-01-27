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
          TConsole.print('Testing: ${Colorize('$method()').cyan()}');
          TConsole.newLine();
          await tests[methods]!();
          TConsole.print('Passed: ${Colorize('$method()').cyan()}');
        } catch (err, stack) {
          TConsole.printError(err, stack);
          TConsole.print('Failed: ${Colorize('$method()').cyan()}');
        }

        TConsole.newLine();
      }
    }
  }

  static Future<void> dispose() async {
    await ExtensionInternals.dispose();
  }
}
