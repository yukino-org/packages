import 'console.dart';
import 'time_tracker.dart';

typedef VoidFutureCallback = Future<void> Function();
typedef OnlyOnAgreeFn = void Function(void Function());

// ignore: avoid_positional_boolean_parameters
OnlyOnAgreeFn onlyOnAgree(final bool agree) => (final void Function() fn) {
      if (agree) fn();
    };

class Benchmarks {
  const Benchmarks({
    required this.name,
    required this.time,
    required this.success,
    required this.result,
  });

  final String name;
  final TimeTracker time;
  final bool success;
  final dynamic result;
}

class BenchmarkRunner {
  static const Duration defaultTimeout = Duration(seconds: 3);

  static Future<Map<String, Benchmarks>> run(
    final Map<String, Future<dynamic> Function()> tests, {
    final bool parseEnvironmentMethod = true,
    final Duration timeout = defaultTimeout,
    final bool verbose = true,
  }) async {
    final OnlyOnAgreeFn whenVerbose = onlyOnAgree(verbose);

    final String? envMethods =
        parseEnvironmentMethod && const bool.hasEnvironment('method')
            ? const String.fromEnvironment('method')
            : null;

    final List<String> methods = envMethods?.split(',') ?? tests.keys.toList();
    final Map<String, Benchmarks> results = <String, Benchmarks>{};

    for (final String x in methods) {
      if (tests.containsKey(x)) {
        final TimeTracker time = TimeTracker()..start();

        try {
          whenVerbose(() {
            TenkaDevConsole.p('Running: ${Colorize('$x()').cyan()}');
          });

          final dynamic result = await tests[x]!();
          results[x] = Benchmarks(
            name: x,
            time: time,
            success: true,
            result: result,
          );

          time.end();
          whenVerbose(() {
            TenkaDevConsole.p(
              'Passed: ${Colorize('$x()').cyan()} ${Colorize('(${time.elapsed}ms)').darkGray()}',
            );
          });
        } catch (err, stack) {
          results[x] = Benchmarks(
            name: x,
            time: time,
            success: false,
            result: err,
          );

          time.end();
          whenVerbose(() {
            TenkaDevConsole.err(err, stack);
            TenkaDevConsole.p(
              'Failed: ${Colorize('$x()').cyan()} ${Colorize('(${time.elapsed}ms)').darkGray()}',
            );
          });
        }

        whenVerbose(() {
          TenkaDevConsole.ln();
        });

        await Future<void>.delayed(defaultTimeout);
      }
    }

    whenVerbose(() {
      final int passed =
          results.values.where((final Benchmarks x) => x.success).length;
      final int failed = results.length - passed;

      TenkaDevConsole.p(
        'Summary: [${Colorize('+$passed').green()} ${Colorize('-$failed').red()}]',
      );

      TenkaDevConsole.p(
        results.entries
            .map(
              (final MapEntry<String, Benchmarks> x) => x.value.success
                  ? '${Colorize('${x.key}()').cyan()}: ${Colorize('P').green()}'
                  : '${Colorize('${x.key}()').cyan()}: ${Colorize('F').red()}',
            )
            .map((final String x) => ' ${Colorize('*').darkGray()} $x')
            .join('\n'),
      );
    });

    return results;
  }
}
