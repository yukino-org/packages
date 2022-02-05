import 'package:extensions/extensions.dart';
import 'package:extensions/metadata.dart';
import 'package:extensions/runtime.dart';
import 'package:hetu_script_dev_tools/hetu_script_dev_tools.dart';
import '../../environment.dart';
import '../../utils/console.dart';
import '../base.dart';

typedef TAnimeExtractorFn<T> = Future<T> Function(AnimeExtractor);

class TAnimeExtractorOptions {
  const TAnimeExtractorOptions({
    required this.source,
    required this.search,
    required this.getInfo,
    required this.getSources,
    this.handleEnvironment = true,
  });

  final ELocalFileDS source;
  final TAnimeExtractorFn<List<SearchInfo>> search;
  final TAnimeExtractorFn<AnimeInfo> getInfo;
  final TAnimeExtractorFn<List<EpisodeSource>> getSources;
  final bool handleEnvironment;
}

class TAnimeExtractor {
  const TAnimeExtractor(this.options);

  final TAnimeExtractorOptions options;

  Future<void> run() async {
    if (options.handleEnvironment) {
      await DTEnvironment.prepare();
    }

    final ERuntimeInstance runtime = await ERuntimeManager.create(
      ERuntimeInstanceOptions(
        hetuSourceContext:
            HTFileSystemResourceContext(root: options.source.root),
      ),
    );

    await runtime.loadScriptCode('', appendDefinitions: true);
    await runtime.loadScriptFile(options.source.file);

    final AnimeExtractor extractor =
        await runtime.getExtractor<AnimeExtractor>();

    await TBase.runTests(
      <String, Future<void> Function()>{
        'search': () async {
          final List<SearchInfo> result = await options.search(extractor);

          TConsole.p('Results (${result.length}):');
          TConsole.p(
            TConsole.qt(
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

          TConsole.p('Result:');
          TConsole.p(TConsole.qt(result.toJson(), spacing: '  '));

          await Future<void>.delayed(const Duration(seconds: 3));
        },
        'getSources': () async {
          final List<EpisodeSource> result =
              await options.getSources(extractor);

          TConsole.p('Results (${result.length}):');
          TConsole.p(
            TConsole.qt(
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
      await DTEnvironment.dispose();
    }
  }
}
