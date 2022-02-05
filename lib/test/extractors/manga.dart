import 'package:extensions/extensions.dart';
import 'package:extensions/metadata.dart';
import 'package:extensions/runtime.dart';
import 'package:hetu_script_dev_tools/hetu_script_dev_tools.dart';
import '../../environment.dart';
import '../../utils/console.dart';
import '../base.dart';

typedef TMangaExtractorFn<T> = Future<T> Function(MangaExtractor);

class TMangaExtractorOptions {
  const TMangaExtractorOptions({
    required this.search,
    required this.getInfo,
    required this.getChapter,
    required this.getPage,
    this.handleEnvironment = true,
  });

  final TMangaExtractorFn<List<SearchInfo>> search;
  final TMangaExtractorFn<MangaInfo> getInfo;
  final TMangaExtractorFn<List<PageInfo>> getChapter;
  final TMangaExtractorFn<ImageDescriber> getPage;
  final bool handleEnvironment;
}

class TMangaExtractor {
  const TMangaExtractor(this.options);

  final TMangaExtractorOptions options;

  Future<void> run(final ELocalFileDS source) async {
    if (options.handleEnvironment) {
      await DTEnvironment.prepare();
    }

    final ERuntimeInstance runtime = await ERuntimeManager.create(
      ERuntimeInstanceOptions(
        hetuSourceContext: HTFileSystemResourceContext(root: source.root),
      ),
    );

    await runtime.loadScriptCode('', appendDefinitions: true);
    await runtime.loadScriptFile(source.file);

    final MangaExtractor extractor =
        await runtime.getExtractor<MangaExtractor>();

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
          final MangaInfo result = await options.getInfo(extractor);

          TConsole.p('Result:');
          TConsole.p(TConsole.qt(result.toJson(), spacing: '  '));
        },
        'getChapter': () async {
          final List<PageInfo> result = await options.getChapter(extractor);

          TConsole.p('Results (${result.length}):');
          TConsole.p(
            TConsole.qt(
              result.map((final PageInfo x) => x.toJson()),
              spacing: '  ',
            ),
          );

          if (result.isEmpty) {
            throw Exception('Empty result');
          }
        },
        'getPage': () async {
          final ImageDescriber result = await options.getPage(extractor);

          TConsole.p('Result:');
          TConsole.p(TConsole.qt(result.toJson(), spacing: '  '));
        }
      },
    );

    if (options.handleEnvironment) {
      await DTEnvironment.dispose();
    }
  }
}
