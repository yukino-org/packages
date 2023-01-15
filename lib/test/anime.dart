import 'package:fubuki_compiler/fubuki_compiler.dart';
import 'package:tenka/tenka.dart';
import '../utils/exports.dart';

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

  Future<Map<String, Benchmarks>> run(
    final TenkaLocalFileDS source, {
    final bool verbose = true,
  }) async {
    final FubukiProgramConstant program = await FubukiCompiler.compileProject(
      root: source.root,
      entrypoint: source.file,
    );
    final TenkaRuntimeInstance runtime =
        await TenkaRuntimeManager.create(program);
    await runtime.initialize();
    final AnimeExtractor extractor = await runtime.getAnimeExtractor();
    final OnlyOnAgreeFn whenVerbose = onlyOnAgree(verbose);

    return BenchmarkRunner.run(
      <String, Future<dynamic> Function()>{
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
            throw ExceptionWithData('Empty result', result);
          }

          return result;
        },
        'getInfo': () async {
          final AnimeInfo result = await getInfo(extractor);

          whenVerbose(() {
            TenkaDevConsole.p('Result:');
            TenkaDevConsole.p(
              TenkaDevConsole.qt(result.toJson(), spacing: '  '),
            );
          });

          return result;
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
            throw ExceptionWithData('Empty result', result);
          }

          return result;
        },
      },
      verbose: verbose,
    );
  }
}
