import 'package:fubuki_compiler/fubuki_compiler.dart';
import 'package:tenka/tenka.dart';
import '../utils/exports.dart';

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
    final FubukiProgramConstant program = await FubukiCompiler.compileProject(
      root: source.root,
      entrypoint: source.file,
    );
    final TenkaRuntimeInstance runtime =
        await TenkaRuntimeManager.create(program);
    final MangaExtractor extractor = await runtime.getMangaExtractor();
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
          final MangaInfo result = await getInfo(extractor);

          whenVerbose(() {
            TenkaDevConsole.p('Result:');
            TenkaDevConsole.p(
              TenkaDevConsole.qt(result.toJson(), spacing: '  '),
            );
          });

          return result;
        },
        'getChapter': () async {
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
        'getPage': () async {
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
