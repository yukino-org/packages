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
    final EMetadata standaloneMetadata = EMetadata(
      name: metadata.name,
      author: metadata.author,
      type: metadata.type,
      source: EBase64DS(bytes),
      thumbnail: metadata.thumbnail,
      nsfw: metadata.nsfw,
    );

    if (outputDir != null) {
      await File(
        path.join(outputDir, '${metadata.id}.json'),
      ).writeAsString(json.encode(standaloneMetadata.toJson()));
    }

    return standaloneMetadata;
  }

  Future<void> testAsAnimeExtractor(
    final TAnimeExtractorOptions options,
  ) async {
    await TAnimeExtractor(options).run();
  }

  Future<void> testAsMangaExtractor(
    final TMangaExtractorOptions options,
  ) async {
    await TMangaExtractor(options).run();
  }

  ELocalFileDS get _castedSource {
    if (metadata.source is! ELocalFileDS) {
      throw Exception('Must be a local file');
    }

    return metadata.source as ELocalFileDS;
  }
}
