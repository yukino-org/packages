import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:extensions/metadata.dart';
import 'package:extensions/runtime.dart';
import 'package:hetu_script_dev_tools/hetu_script_dev_tools.dart';
import 'package:path/path.dart' as path;
import '../test/extractors/anime.dart';
import '../test/extractors/manga.dart';

class EConfig {
  const EConfig(this.metadata);

  final EMetadata metadata;

  Future<EMetadata> compile([final String? outputDir]) async {
    final ERuntimeInstance runtime = await ERuntimeManager.create(
      ERuntimeInstanceOptions(
        hetuSourceContext:
            HTFileSystemResourceContext(root: _castedSource.root),
      ),
    );

    await runtime.loadScriptCode('', appendDefinitions: true);

    final Uint8List bytes = await runtime.compileScriptFile(_castedSource.file);
    final EMetadata aotMetadata = EMetadata(
      name: metadata.name,
      author: metadata.author,
      type: metadata.type,
      repo: metadata.repo,
      source: EAotContext(bytes),
      thumbnail: metadata.thumbnail,
      nsfw: metadata.nsfw,
    );

    if (outputDir != null) {
      await File(
        path.join(outputDir, '${metadata.id}.json'),
      ).writeAsString(json.encode(aotMetadata.toJson()));
    }

    return aotMetadata;
  }

  Future<void> testAsAnimeExtractor({
    required final TAnimeExtractorFn search,
    required final TAnimeExtractorFn getInfo,
    required final TAnimeExtractorFn getSources,
  }) async {
    await TAnimeExtractor.testFile(
      root: _castedSource.root,
      file: _castedSource.file,
      search: search,
      getInfo: getInfo,
      getSources: getSources,
    );
  }

  Future<void> testAsMangaExtractor({
    required final TMangaExtractorFn search,
    required final TMangaExtractorFn getInfo,
    required final TMangaExtractorFn getChapter,
    required final TMangaExtractorFn getPage,
  }) async {
    await TMangaExtractor.testFile(
      root: _castedSource.root,
      file: _castedSource.file,
      search: search,
      getInfo: getInfo,
      getChapter: getChapter,
      getPage: getPage,
    );
  }

  ELocalContext get _castedSource {
    if (metadata.source is! ELocalContext) {
      throw Exception('Must be a local context');
    }

    return metadata.source as ELocalContext;
  }
}
