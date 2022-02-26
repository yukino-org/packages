import 'dart:io';
import 'package:hetu_script_dev_tools/hetu_script_dev_tools.dart';
import 'package:tenka/tenka.dart';
import '../../environment.dart';
import '../../utils/console.dart';
import '../../utils/runner.dart';

typedef MockedMangaExtractorFn<T> = Future<T> Function(MangaExtractor);

class MockedMangaExtractorOptions {
  const MockedMangaExtractorOptions({
    required this.search,
    required this.getInfo,
    required this.getChapter,
    required this.getPage,
    this.handleEnvironment = true,
    this.exitAfterRun = false,
    this.setExitCode = true,
  });

  final MockedMangaExtractorFn<List<SearchInfo>> search;
  final MockedMangaExtractorFn<MangaInfo> getInfo;
  final MockedMangaExtractorFn<List<PageInfo>> getChapter;
  final MockedMangaExtractorFn<ImageDescriber> getPage;
  final bool handleEnvironment;
  final bool exitAfterRun;
  final bool setExitCode;
}

class MockedMangaExtractor {
  const MockedMangaExtractor(this.options);

  final MockedMangaExtractorOptions options;

  Future<void> run(final TenkaLocalFileDS source) async {
    if (options.handleEnvironment) {
      await TenkaDevEnvironment.prepare();
    }

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
          final List<SearchInfo> result = await options.search(extractor);

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
          final MangaInfo result = await options.getInfo(extractor);

          TenkaDevConsole.p('Result:');
          TenkaDevConsole.p(TenkaDevConsole.qt(result.toJson(), spacing: '  '));
        },
        'getChapter': () async {
          final List<PageInfo> result = await options.getChapter(extractor);

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
          final ImageDescriber result = await options.getPage(extractor);

          TenkaDevConsole.p('Result:');
          TenkaDevConsole.p(TenkaDevConsole.qt(result.toJson(), spacing: '  '));
        }
      },
    );

    if (options.handleEnvironment) {
      await TenkaDevEnvironment.dispose();
    }

    if (options.setExitCode) {
      exitCode = results.values.any((final bool x) => !x) ? 1 : 0;
    }

    if (options.exitAfterRun) {
      exit(exitCode);
    }
  }
}
