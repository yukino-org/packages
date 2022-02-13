import 'dart:io';
import 'package:extensions/metadata.dart';
import 'package:extensions/runtime.dart';
import 'package:hetu_script_dev_tools/hetu_script_dev_tools.dart';
import 'package:yaml/yaml.dart';
import '../test/anime.dart';
import '../test/manga.dart';

export 'package:hetu_script_dev_tools/hetu_script_dev_tools.dart'
    show HTFileSystemResourceContext;

class ECompileOptions {
  const ECompileOptions({
    this.outputDir,
    this.handleEnvironment = true,
  });

  final String? outputDir;
  final bool handleEnvironment;

  static const ECompileOptions defaultOptions = ECompileOptions();
}

class EConfig {
  const EConfig(this.metadata);

  factory EConfig.parse(final String yaml) => EConfig(
        EMetadata.fromJson(loadYaml(yaml) as Map<dynamic, dynamic>),
      );

  final EMetadata metadata;

  Future<EMetadata> compile() async {
    final ERuntimeInstance runtime = await ERuntimeManager.create(
      ERuntimeInstanceOptions(
        hetuSourceContext:
            HTFileSystemResourceContext(root: _castedSource.root),
      ),
    );

    await runtime.loadScriptCode('', appendDefinitions: true);

    final EDataSource source =
        EBase64DS(await runtime.compileScriptFile(_castedSource.file));

    final EDataSource image = metadata.source is ELocalFileDS
        ? (await EBase64DS.fromLocalFile(metadata.source as ELocalFileDS))
        : metadata.source;

    final EMetadata standaloneMetadata = EMetadata(
      name: metadata.name,
      type: metadata.type,
      source: source,
      thumbnail: image,
      nsfw: metadata.nsfw,
    );

    return standaloneMetadata;
  }

  Future<void> test<T>(final T options) async {
    if (options is TAnimeExtractorOptions) {
      await TAnimeExtractor(options).run(_castedSource);
    } else if (options is TMangaExtractorOptions) {
      await TMangaExtractor(options).run(_castedSource);
    } else {
      throw Exception('Unsupported options');
    }
  }

  ELocalFileDS get _castedSource {
    if (metadata.source is! ELocalFileDS) {
      throw Exception('Must be a local file');
    }

    return metadata.source as ELocalFileDS;
  }

  static Future<EConfig> parseFile(final File file) async =>
      EConfig.parse(await file.readAsString());
}
