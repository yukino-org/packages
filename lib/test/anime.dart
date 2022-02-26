import 'dart:io';
import 'package:hetu_script_dev_tools/hetu_script_dev_tools.dart';
import 'package:tenka/tenka.dart';
import '../../environment.dart';
import '../../utils/console.dart';
import '../../utils/runner.dart';

typedef TAnimeExtractorFn<T> = Future<T> Function(AnimeExtractor);

class MockedAnimeExtractorOptions {
  const MockedAnimeExtractorOptions({
    required this.search,
    required this.getInfo,
    required this.getSources,
    this.handleEnvironment = true,
    this.exitAfterRun = false,
    this.setExitCode = true,
  });

  final TAnimeExtractorFn<List<SearchInfo>> search;
  final TAnimeExtractorFn<AnimeInfo> getInfo;
  final TAnimeExtractorFn<List<EpisodeSource>> getSources;
  final bool handleEnvironment;
  final bool exitAfterRun;
  final bool setExitCode;
}

class MockedAnimeExtractor {
  const MockedAnimeExtractor(this.options);

  final MockedAnimeExtractorOptions options;

  Future<void> run(final TenkaLocalFileDS source) async {
    if (options.handleEnvironment) {
      await TenkaDevEnvironment.prepare();
    }

    final TenkaRuntimeInstance runtime = await TenkaRuntimeManager.create(
      TenkaRuntimeInstanceOptions(
        hetuSourceContext: HTFileSystemResourceContext(root: source.root),
      ),
    );

    await runtime.loadScriptCode('', appendDefinitions: true);
    await runtime.loadScriptFile(source.file);

    final AnimeExtractor extractor =
        await runtime.getExtractor<AnimeExtractor>();

    final Map<String, bool> results = await Runner.run(
      <String, Future<void> Function()>{
        'search': () async {
          final List<SearchInfo> result = await options.search(extractor);

          TenkaDevConsole.p('Results (${result.length}):');
          TenkaDevConsole.p(
            TenkaDevConsole.qt(
              result.map((final SearchInfo x) => x.toJson()),
              spacing: '  ',
            ),
          );

          if (result.isEmpty) {
            throw Exception('Empty result');
          }
        },
        'getInfo': () async {
          final AnimeInfo result = await options.getInfo(extractor);

          TenkaDevConsole.p('Result:');
          TenkaDevConsole.p(TenkaDevConsole.qt(result.toJson(), spacing: '  '));

          await Future<void>.delayed(const Duration(seconds: 3));
        },
        'getSources': () async {
          final List<EpisodeSource> result =
              await options.getSources(extractor);

          TenkaDevConsole.p('Results (${result.length}):');
          TenkaDevConsole.p(
            TenkaDevConsole.qt(
              result.map((final EpisodeSource x) => x.toJson()),
              spacing: '  ',
            ),
          );

          if (result.isEmpty) {
            throw Exception('Empty result');
          }
        },
      },
    );

    if (options.handleEnvironment) {
      await TenkaDevEnvironment.dispose();
    }

    if (options.setExitCode) {
      exitCode = results.values.any((final bool x) => !x) ? 1 : 0;
    }

    if (options.exitAfterRun) {
      exit(exitCode);
    }
  }
}
