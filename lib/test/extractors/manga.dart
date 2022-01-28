import 'package:extensions/extensions.dart';
import 'package:hetu_script_dev_tools/hetu_script_dev_tools.dart';
import 'package:utilx/utilities/locale.dart';
import '../../utils/console.dart';
import '../environment.dart';

class TMangaExtractor {
  const TMangaExtractor(this.extractor);

  final MangaExtractor extractor;

  Future<void> search(final String terms, final Locale locale) async {
    final List<SearchInfo> result = await extractor.search(terms, locale);

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
  }

  Future<void> getInfo(final String url, final Locale locale) async {
    final MangaInfo result = await extractor.getInfo(url, locale);

    TConsole.p('Result:');
    TConsole.p(TConsole.qt(result.toJson(), spacing: '  '));
  }

  Future<void> getChapter(final ChapterInfo chapter) async {
    final List<PageInfo> result = await extractor.getChapter(chapter);

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
  }

  Future<void> getPage(final PageInfo page) async {
    final ImageDescriber result = await extractor.getPage(page);

    TConsole.p('Result:');
    TConsole.p(TConsole.qt(result.toJson(), spacing: '  '));
  }

  static Future<void> testFile({
    required final String root,
    required final String file,
    required final Future<void> Function(TMangaExtractor) search,
    required final Future<void> Function(TMangaExtractor) getInfo,
    required final Future<void> Function(TMangaExtractor) getChapter,
    required final Future<void> Function(TMangaExtractor) getPage,
  }) async {
    await TEnvironment.prepare();

    final ERuntimeInstance runtime = await ERuntimeManager.create(
      ERuntimeInstanceOptions(
        hetuSourceContext: HTFileSystemResourceContext(root: root),
      ),
    );

    await runtime.loadScriptCode('', appendDefinitions: true);
    await runtime.loadScriptFile(file);

    final MangaExtractor extractor =
        await runtime.getExtractor<MangaExtractor>();

    final TMangaExtractor client = TMangaExtractor(extractor);

    await TEnvironment.runTests(<String, Future<void> Function()>{
      'search': () async {
        await search(client);
        await Future<void>.delayed(const Duration(seconds: 3));
      },
      'getInfo': () async {
        await getInfo(client);
        await Future<void>.delayed(const Duration(seconds: 3));
      },
      'getChapter': () async {
        await getChapter(client);
        await Future<void>.delayed(const Duration(seconds: 3));
      },
      'getPage': () async {
        await getPage(client);
        await Future<void>.delayed(const Duration(seconds: 3));
      }
    });

    await TEnvironment.dispose();
  }
}
