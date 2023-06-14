import 'package:tenka/tenka.dart';
import '../compiler.dart';
import '../utils/exports.dart';

typedef TAnimeExtractorFn<T> = Future<T> Function(AnimeExtractor);

class MockedAnimeExtractor {
  const MockedAnimeExtractor({
    required this.search,
    required this.getInfo,
    required this.getSource,
  });

  final TAnimeExtractorFn<List<SearchInfo>> search;
  final TAnimeExtractorFn<AnimeInfo> getInfo;
  final TAnimeExtractorFn<EpisodeSource> getSource;

  Future<Map<String, Benchmarks>> run(
    final TenkaLocalFileDS source, {
    final bool verbose = true,
  }) async {
    final BaizeProgramConstant program = await TenkaCompiler.compile(source);
    final TenkaRuntimeInstance runtime =
        await TenkaRuntimeManager.create(program);
    final AnimeExtractor extractor = await runtime.getAnimeExtractor();
    final OnlyOnAgreeFn whenVerbose = onlyOnAgree(verbose);

    return BenchmarkRunner.run(
      <String, Future<dynamic> Function()>{
        TenkaBaizeConverter.kSearch: () async {
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
            throw ExceptionWithData('Empty result', result);
          }

          return result;
        },
        TenkaBaizeConverter.kGetInfo: () async {
          final AnimeInfo result = await getInfo(extractor);

          whenVerbose(() {
            TenkaDevConsole.p('Result:');
            TenkaDevConsole.p(
              TenkaDevConsole.qt(result.toJson(), spacing: '  '),
            );
          });

          return result;
        },
        TenkaBaizeConverter.kGetSource: () async {
          final EpisodeSource result = await getSource(extractor);

          whenVerbose(() {
            TenkaDevConsole.p('Results (streams: ${result.streams.length}):');
            TenkaDevConsole.p(
              TenkaDevConsole.qt(
                result.streams.map((final EpisodeStream x) => x.toJson()),
                spacing: '  ',
              ),
            );
            TenkaDevConsole.p('Results (subtitles: ${result.streams.length}):');
            TenkaDevConsole.p(
              TenkaDevConsole.qt(
                result.subtitles.map((final EpisodeSubtitle x) => x.toJson()),
                spacing: '  ',
              ),
            );
          });

          if (result.streams.isEmpty) {
            throw ExceptionWithData('Empty result (streams)', result);
          }

          return result;
        },
      },
      verbose: verbose,
    );
  }
}
