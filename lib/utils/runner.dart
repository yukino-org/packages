import 'console.dart';
import 'time_tracker.dart';

typedef VoidFutureCallback = Future<void> Function();

class Runner {
  static const Duration defaultTimeout = Duration(seconds: 3);

  static Future<Map<String, bool>> run(
    final Map<String, Future<void> Function()> tests, {
    final bool parseEnvironmentMethod = true,
    final Duration timeout = defaultTimeout,
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
          TenkaDevConsole.p('Running: ${Colorize('$x()').cyan()}');

          await tests[x]!();

          result[x] = true;
          TenkaDevConsole.p(
            'Passed: ${Colorize('$x()').cyan()} ${Colorize('(${time.elapsed}ms)').darkGray()}',
          );
        } catch (err, stack) {
          result[x] = false;
          TenkaDevConsole.err(err, stack);
          TenkaDevConsole.p(
            'Failed: ${Colorize('$x()').cyan()} ${Colorize('(${time.elapsed}ms)').darkGray()}',
          );
        }

        TenkaDevConsole.ln();
        await Future<void>.delayed(defaultTimeout);
      }
    }

    final int passed =
        result.values.fold(0, (final int pv, final bool x) => x ? pv + 1 : pv);
    final int failed = result.length - passed;

    TenkaDevConsole.p(
      'Summary: [${Colorize('+$passed').green()} ${Colorize('-$failed').red()}]',
    );

    TenkaDevConsole.p(
      result.entries
          .map(
            (final MapEntry<String, bool> x) => x.value
                ? '${Colorize('${x.key}()').cyan()}: ${Colorize('P').green()}'
                : '${Colorize('${x.key}()').cyan()}: ${Colorize('F').red()}',
          )
          .map((final String x) => ' ${Colorize('*').darkGray()} $x')
          .join('\n'),
    );

    return result;
  }
}
