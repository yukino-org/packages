import 'dart:io';
import 'package:extensions/extensions.dart';
import 'package:utilx/utilities/locale.dart';
import '../../utils/console.dart';
import '../environment.dart';

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

  static Future<void> testFile(
    final String path, {
    required final Future<void> Function(TAnimeExtractor) search,
    required final Future<void> Function(TAnimeExtractor) getInfo,
    required final Future<void> Function(TAnimeExtractor) getSources,
  }) async {
    await TEnvironment.prepare();

    final File script = File(path);
    final ERuntimeInstance runtime = await ERuntimeManager.create();

    await runtime.loadScriptCode(
      await script.readAsString(),
      appendDefinitions: true,
    );

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
