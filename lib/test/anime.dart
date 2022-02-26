import 'package:hetu_script_dev_tools/hetu_script_dev_tools.dart';
import 'package:tenka/tenka.dart';
import '../../utils/console.dart';
import '../../utils/runner.dart';

typedef TAnimeExtractorFn<T> = Future<T> Function(AnimeExtractor);

class MockedAnimeExtractor {
  const MockedAnimeExtractor({
    required this.search,
    required this.getInfo,
    required this.getSources,
  });

  final TAnimeExtractorFn<List<SearchInfo>> search;
  final TAnimeExtractorFn<AnimeInfo> getInfo;
  final TAnimeExtractorFn<List<EpisodeSource>> getSources;

  Future<Map<String, bool>> run(
    final TenkaLocalFileDS source, {
    final bool verbose = true,
  }) async {
    final TenkaRuntimeInstance runtime = await TenkaRuntimeManager.create(
      TenkaRuntimeInstanceOptions(
        hetuSourceContext: HTFileSystemResourceContext(root: source.root),
      ),
    );

    await runtime.loadScriptCode('', appendDefinitions: true);
    await runtime.loadScriptFile(source.file);

    final AnimeExtractor extractor =
        await runtime.getExtractor<AnimeExtractor>();

    final OnlyOnAgreeFn whenVerbose = onlyOnAgree(verbose);
    final Map<String, bool> results = await Runner.run(
      <String, Future<void> Function()>{
        'search': () async {
          final List<SearchInfo> result = await search(extractor);

          whenVerbose(() {
            TenkaDevConsole.p('Results (${result.length}):');
            TenkaDevConsole.p(
              TenkaDevConsole.qt(
                result.map((final SearchInfo x) => x.toJson()),
                spacing: '  ',
              ),
            );
          });

          if (result.isEmpty) {
            throw Exception('Empty result');
          }
        },
        'getInfo': () async {
          final AnimeInfo result = await getInfo(extractor);

          whenVerbose(() {
            TenkaDevConsole.p('Result:');
            TenkaDevConsole.p(
              TenkaDevConsole.qt(result.toJson(), spacing: '  '),
            );
          });

          await Future<void>.delayed(const Duration(seconds: 3));
        },
        'getSources': () async {
          final List<EpisodeSource> result = await getSources(extractor);

          whenVerbose(() {
            TenkaDevConsole.p('Results (${result.length}):');
            TenkaDevConsole.p(
              TenkaDevConsole.qt(
                result.map((final EpisodeSource x) => x.toJson()),
                spacing: '  ',
              ),
            );
          });

          if (result.isEmpty) {
            throw Exception('Empty result');
          }
        },
      },
      verbose: verbose,
    );

    return results;
  }
}
