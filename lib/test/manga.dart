import 'package:tenka/tenka.dart';
import '../tenka_dev_tools.dart';

typedef MockedMangaExtractorFn<T> = Future<T> Function(MangaExtractor);

class MockedMangaExtractor {
  const MockedMangaExtractor({
    required this.search,
    required this.getInfo,
    required this.getChapter,
    required this.getPage,
  });

  final MockedMangaExtractorFn<List<SearchInfo>> search;
  final MockedMangaExtractorFn<MangaInfo> getInfo;
  final MockedMangaExtractorFn<List<PageInfo>> getChapter;
  final MockedMangaExtractorFn<ImageDescriber> getPage;

  Future<Map<String, Benchmarks>> run(
    final TenkaLocalFileDS source, {
    final bool verbose = true,
  }) async {
    final BeizeProgramConstant program = await TenkaCompiler.compile(source);
    final TenkaRuntimeInstance runtime =
        await TenkaRuntimeManager.create(program);
    final MangaExtractor extractor = await runtime.getMangaExtractor();
    final OnlyOnAgreeFn whenVerbose = onlyOnAgree(verbose);

    return BenchmarkRunner.run(
      <String, Future<dynamic> Function()>{
        TenkaBeizeConverter.kSearch: () async {
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
        TenkaBeizeConverter.kGetInfo: () async {
          final MangaInfo result = await getInfo(extractor);

          whenVerbose(() {
            TenkaDevConsole.p('Result:');
            TenkaDevConsole.p(
              TenkaDevConsole.qt(result.toJson(), spacing: '  '),
            );
          });

          return result;
        },
        TenkaBeizeConverter.kGetChapter: () async {
          final List<PageInfo> result = await getChapter(extractor);

          whenVerbose(() {
            TenkaDevConsole.p('Results (${result.length}):');
            TenkaDevConsole.p(
              TenkaDevConsole.qt(
                result.map((final PageInfo x) => x.toJson()),
                spacing: '  ',
              ),
            );
          });

          if (result.isEmpty) {
            throw ExceptionWithData('Empty result', result);
          }

          return result;
        },
        TenkaBeizeConverter.kGetPage: () async {
          final ImageDescriber result = await getPage(extractor);

          whenVerbose(() {
            TenkaDevConsole.p('Result:');
            TenkaDevConsole.p(
              TenkaDevConsole.qt(result.toJson(), spacing: '  '),
            );
          });

          return result;
        }
      },
      verbose: verbose,
    );
  }
}
