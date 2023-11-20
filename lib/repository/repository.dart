import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:utilx/utilx.dart';
import 'store_repository.dart';

class TenkaRepository {
  TenkaRepository({
    required this.baseDir,
  });

  final String baseDir;

  late final Map<String, TenkaStoreRepository> installed;

  Future<void> initialize() async {
    await _createDirs();
    await _loadStoreUrls();
  }

  bool isInstalled(final String storeUrl) => installed.containsKey(storeUrl);

  Future<void> install(final String storeUrl) async {
    await _loadStoreUrl(storeUrl);
    await saveStoreUrls();
  }

  Future<void> uninstall(final String storeUrl) async {
    final TenkaStoreRepository? removed = installed.remove(storeUrl);
    if (removed == null) return;
    await saveStoreUrls();
    await Directory(removed.baseDir).delete(recursive: true);
  }

  Future<void> saveStoreUrls() async {
    final File storeUrlsFile = File(storeUrlsFilePath);
    await storeUrlsFile.writeAsString(json.encode(installed.keys.toList()));
  }

  Future<void> _createDirs() async {
    final List<String> dirs = <String>[baseDir];
    for (final String x in dirs) {
      await FSUtils.ensureDirectory(Directory(x));
    }
  }

  Future<void> _loadStoreUrls() async {
    final File storeUrlsFile = File(storeUrlsFilePath);
    installed = <String, TenkaStoreRepository>{};
    if (await storeUrlsFile.exists()) {
      final List<String> storeUrls =
          (json.decode(await storeUrlsFile.readAsString()) as List<dynamic>)
              .cast();
      for (final String x in storeUrls) {
        await _loadStoreUrl(x);
      }
    }
    await saveStoreUrls();
  }

  Future<void> _loadStoreUrl(final String storeUrl) async {
    final String uid = StringUtils.substringLast(
      StringUtils.replaceIllegalCharacters(storeUrl),
      32,
    );
    final TenkaStoreRepository storeRepository = TenkaStoreRepository(
      storeUrl: storeUrl,
      baseDir: path.join(baseDir, uid),
    );
    await storeRepository.initialize();
    installed[storeUrl] = storeRepository;
  }

  String get storeUrlsFilePath => path.join(baseDir, 'urls.json');
}
