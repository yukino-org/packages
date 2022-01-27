import 'dart:io';
import 'package:extensions/extensions.dart';
import 'package:test/test.dart';
import 'package:utilx/utilities/locale.dart';
import '../../utils/console.dart';
import '../../utils/timer.dart';
import '../environment.dart';

class TMangaExtractor {
  const TMangaExtractor(this.extractor);

  final MangaExtractor extractor;

  Future<void> search(final String terms, final Locale locale) async {
    final TTimer timer = TTimer()..start();
    final List<SearchInfo> result = await extractor.search(terms, locale);

    TConsole.print('Results (${result.length}):');
    TConsole.print(
      TConsole.prettify(
        result.map((final SearchInfo x) => x.toJson()),
        spacing: '  ',
      ),
    );

    if (result.isEmpty) {
      timer.fail();
      throw Exception('Empty result');
    }

    timer.pass();
  }

  Future<void> getInfo(final String url, final Locale locale) async {
    final TTimer timer = TTimer()..start();
    final MangaInfo result = await extractor.getInfo(url, locale);

    TConsole.print('Result:');
    TConsole.print(TConsole.prettify(result.toJson(), spacing: '  '));

    timer.pass();
  }

  Future<void> getChapter(final ChapterInfo chapter) async {
    final TTimer timer = TTimer()..start();
    final List<PageInfo> result = await extractor.getChapter(chapter);

    TConsole.print('Results (${result.length}):');
    TConsole.print(
      TConsole.prettify(
        result.map((final PageInfo x) => x.toJson()),
        spacing: '  ',
      ),
    );

    if (result.isEmpty) {
      timer.fail();
      throw Exception('Empty result');
    }

    timer.pass();
  }

  Future<void> getPage(final PageInfo page) async {
    final TTimer timer = TTimer()..start();
    final ImageDescriber result = await extractor.getPage(page);

    TConsole.print('Result:');
    TConsole.print(TConsole.prettify(result.toJson(), spacing: '  '));

    timer.pass();
  }

  static Future<void> testFile(
    final String path, {
    required final Future<void> Function(TMangaExtractor) search,
    required final Future<void> Function(TMangaExtractor) getInfo,
    required final Future<void> Function(TMangaExtractor) getChapter,
    required final Future<void> Function(TMangaExtractor) getPage,
  }) async {
    setUpAll(() async {
      await TEnvironment.prepare();
    });

    final File script = File(path);
    final ERuntimeInstance runtime = await ERuntimeManager.create();

    await runtime.loadScriptCode(
      await script.readAsString(),
      appendDefinitions: true,
    );

    final MangaExtractor extractor =
        await runtime.getExtractor<MangaExtractor>();

    final TMangaExtractor client = TMangaExtractor(extractor);

    TEnvironment.runTests(<String, Future<void> Function()>{
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

    tearDownAll(() async {
      await TEnvironment.dispose();
    });
  }
}
