import 'package:hetu_script_dev_tools/hetu_script_dev_tools.dart';
import 'package:tenka/tenka.dart';
import '../../utils/console.dart';
import '../../utils/runner.dart';

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

  Future<Map<String, bool>> run(final TenkaLocalFileDS source) async {
    final TenkaRuntimeInstance runtime = await TenkaRuntimeManager.create(
      TenkaRuntimeInstanceOptions(
        hetuSourceContext: HTFileSystemResourceContext(root: source.root),
      ),
    );

    await runtime.loadScriptCode('', appendDefinitions: true);
    await runtime.loadScriptFile(source.file);

    final MangaExtractor extractor =
        await runtime.getExtractor<MangaExtractor>();

    final Map<String, bool> results = await Runner.run(
      <String, Future<void> Function()>{
        'search': () async {
          final List<SearchInfo> result = await search(extractor);

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
          final MangaInfo result = await getInfo(extractor);

          TenkaDevConsole.p('Result:');
          TenkaDevConsole.p(TenkaDevConsole.qt(result.toJson(), spacing: '  '));
        },
        'getChapter': () async {
          final List<PageInfo> result = await getChapter(extractor);

          TenkaDevConsole.p('Results (${result.length}):');
          TenkaDevConsole.p(
            TenkaDevConsole.qt(
              result.map((final PageInfo x) => x.toJson()),
              spacing: '  ',
            ),
          );

          if (result.isEmpty) {
            throw Exception('Empty result');
          }
        },
        'getPage': () async {
          final ImageDescriber result = await getPage(extractor);

          TenkaDevConsole.p('Result:');
          TenkaDevConsole.p(TenkaDevConsole.qt(result.toJson(), spacing: '  '));
        }
      },
    );

    return results;
  }
}
