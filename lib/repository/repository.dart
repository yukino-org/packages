import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:utilx/utils.dart';
import '../data/exports.dart';
import '../metadata/exports.dart';
import '../store/exports.dart';
import 'url.dart';

class TenkaRepository {
  TenkaRepository({
    required this.resolver,
    required this.baseDir,
  });

  final TenkaStoreURLResolver resolver;
  final String baseDir;

  late final TenkaStore store;
  late final Map<String, TenkaMetadata> installed;

  Future<void> initialize() async {
    await _createDirs();
    await _loadStore();
    await _loadModules();
  }

  bool isInstalled(final TenkaMetadata metadata) =>
      installed.containsKey(metadata.id);

  Future<void> install(final TenkaMetadata metadata) async {
    final TenkaMetadata resolved = await resolveMetadata(metadata);
    installed[resolved.id] = resolved;
    await saveLocalModules();
  }

  Future<void> uninstall(final TenkaMetadata metadata) async {
    installed.remove(metadata.id);
    await saveLocalModules();
  }

  Future<void> _createDirs() async {
    final List<String> dirs = <String>[baseDir, cacheDirPath];

    for (final String x in dirs) {
      final Directory dir = Directory(x);
      if (!(await dir.exists())) {
        await dir.create(recursive: true);
      }
    }
  }

  Future<TenkaMetadata> resolveMetadata(final TenkaMetadata metadata) async {
    if (metadata.thumbnail is! TenkaCloudDS ||
        metadata.source is! TenkaCloudDS) {
      throw Exception('`thumbnail` and `source` must be `TenkaCloudDS`');
    }

    final TenkaDataSource source =
        await _getBase64FromCloudDS(metadata.source as TenkaCloudDS);

    final TenkaDataSource thumbnail =
        await _getBase64FromCloudDS(metadata.thumbnail as TenkaCloudDS);

    return TenkaMetadata(
      id: metadata.id,
      name: metadata.name,
      type: metadata.type,
      author: metadata.author,
      source: source,
      thumbnail: thumbnail,
      nsfw: metadata.nsfw,
      version: metadata.version,
      deprecated: metadata.deprecated,
    );
  }

  Future<TenkaBase64DS> _getBase64FromCloudDS(final TenkaCloudDS source) async {
    final http.Response resp =
        await http.get(Uri.parse(source.resolveURL(resolver)));

    return TenkaBase64DS(resp.bodyBytes);
  }

  Future<void> saveLocalModules() async {
    final File mainFile = File(modulesFilePath);

    await mainFile.writeAsString(
      json.encode(
        installed.values.map((final TenkaMetadata x) => x.toJson()).toList(),
      ),
    );
  }

  Future<void> _loadModules() async {
    final File mainFile = File(modulesFilePath);

    installed = <String, TenkaMetadata>{};

    if (await mainFile.exists()) {
      for (final dynamic x
          in json.decode(await mainFile.readAsString()) as List<dynamic>) {
        TenkaMetadata metadata = TenkaMetadata.fromJson(x as JsonMap);

        final TenkaMetadata? currentMetadata = store.modules[metadata.id];

        if (currentMetadata != null &&
            currentMetadata.version > metadata.version) {
          metadata = await resolveMetadata(currentMetadata);
        }

        installed[metadata.id] = metadata;
      }
    }

    await saveLocalModules();
  }

  Future<void> _loadStore() async {
    final String currentChecksum = await _getLatestChecksum();
    final File storeChecksumCacheFile = File(cachedStoreChecksumFilePath);
    final File storeCacheFile = File(cachedStoreFilePath);

    if (await storeChecksumCacheFile.exists()) {
      final String cachedChecksum = await storeChecksumCacheFile.readAsString();

      if (cachedChecksum == currentChecksum) {
        store = TenkaStore.fromJson(
          json.decode(await storeCacheFile.readAsString()) as JsonMap,
        );

        return;
      }
    }

    final TenkaStore currentStore = await _getLatestStore();
    await storeChecksumCacheFile.writeAsString(currentChecksum);
    await storeCacheFile.writeAsString(json.encode(currentStore.toJson()));

    store = currentStore;
  }

  Future<String> _getLatestChecksum() async {
    final http.Response resp = await http.get(Uri.parse(resolver.checksumURL));

    return resp.body;
  }

  Future<TenkaStore> _getLatestStore() async {
    final http.Response resp = await http.get(Uri.parse(resolver.storeURL));

    return TenkaStore.fromJson(json.decode(resp.body) as JsonMap);
  }

  String get modulesFilePath => path.join(baseDir, 'modules.json');
  String get cacheDirPath => path.join(baseDir, 'cache');
  String get cachedStoreFilePath => path.join(cacheDirPath, 'store.json');
  String get cachedStoreChecksumFilePath =>
      path.join(cacheDirPath, '.checksum');
}
