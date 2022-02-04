import 'package:extensions/extensions.dart';
import 'package:extensions/runtime.dart';
import 'package:hetu_script_dev_tools/hetu_script_dev_tools.dart';
import 'package:utilx/utilities/locale.dart';
import '../../utils/console.dart';
import '../environment.dart';

typedef TAnimeExtractorFn = Future<void> Function(TAnimeExtractor);

class TAnimeExtractor {
  const TAnimeExtractor(this.extractor);

  final AnimeExtractor extractor;

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
    final AnimeInfo result = await extractor.getInfo(url, locale);

    TConsole.p('Result:');
    TConsole.p(TConsole.qt(result.toJson(), spacing: '  '));
  }

  Future<void> getSources(final EpisodeInfo episode) async {
    final List<EpisodeSource> result = await extractor.getSources(episode);

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
  }

  static Future<void> testFile({
    required final String root,
    required final String file,
    required final TAnimeExtractorFn search,
    required final TAnimeExtractorFn getInfo,
    required final TAnimeExtractorFn getSources,
  }) async {
    await TEnvironment.prepare();

    final ERuntimeInstance runtime = await ERuntimeManager.create(
      ERuntimeInstanceOptions(
        hetuSourceContext: HTFileSystemResourceContext(root: root),
      ),
    );

    await runtime.loadScriptCode('', appendDefinitions: true);
    await runtime.loadScriptFile(file);

    final AnimeExtractor extractor =
        await runtime.getExtractor<AnimeExtractor>();

    final TAnimeExtractor client = TAnimeExtractor(extractor);

    await TEnvironment.runTests(<String, Future<void> Function()>{
      'search': () async {
        await search(client);
        await Future<void>.delayed(const Duration(seconds: 3));
      },
      'getInfo': () async {
        await getInfo(client);
        await Future<void>.delayed(const Duration(seconds: 3));
      },
      'getSources': () async {
        await getSources(client);
        await Future<void>.delayed(const Duration(seconds: 3));
      }
    });

    await TEnvironment.dispose();
  }
}
