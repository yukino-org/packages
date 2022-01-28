import 'package:extensions/extensions.dart';
import '../utils/console.dart';
import '../utils/time_tracker.dart';

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
    final bool throwIfAnyFails = true,
  }) async {
    final String? envMethods =
        parseEnvironmentMethod && const bool.hasEnvironment('method')
            ? const String.fromEnvironment('method')
            : null;

    final List<String> methods = envMethods?.split(',') ?? tests.keys.toList();
    final Map<String, bool> result = <String, bool>{};

    for (final String x in methods) {
      if (tests.containsKey(x)) {
        final TimeTracker time = TimeTracker()..start();

        try {
          TConsole.p('Running: ${Colorize('$x()').cyan()}');

          await tests[x]!();

          result[x] = true;
          TConsole.p(
            'Passed: ${Colorize('$x()').cyan()} ${Colorize('(${time.elapsed}ms)').darkGray()}',
          );
        } catch (err, stack) {
          result[x] = false;
          TConsole.err(err, stack);
          TConsole.p(
            'Failed: ${Colorize('$x()').cyan()} ${Colorize('(${time.elapsed}ms)').darkGray()}',
          );
        }

        TConsole.ln();
      }
    }

    final int passed =
        result.values.fold(0, (final int pv, final bool x) => x ? pv + 1 : pv);
    final int failed = result.length - passed;

    TConsole.p(
      'Summary: [${Colorize('+$passed').green()} ${Colorize('-$failed').red()}]',
    );

    TConsole.p(
      result.entries
          .map(
            (final MapEntry<String, bool> x) => x.value
                ? '${Colorize('${x.key}()').cyan()}: ${Colorize('P').green()}'
                : '${Colorize('${x.key}()').cyan()}: ${Colorize('F').red()}',
          )
          .map((final String x) => ' ${Colorize('*').darkGray()} $x')
          .join('\n'),
    );

    if (throwIfAnyFails && failed > 0) {
      throw Error();
    }
  }

  static Future<void> dispose() async {
    await ExtensionInternals.dispose();
  }
}
