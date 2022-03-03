import 'dart:convert';
import 'package:path/path.dart' as path;
import '../model.dart';

class TenkaLocalFileDS extends TenkaDataSource {
  TenkaLocalFileDS({
    required this.root,
    required this.file,
  });

  final String root;
  final String file;

  String get fullPath => path.join(root, file);

  @override
  TenkaDataSourceConverter<dynamic> get converter =>
      TenkaLocalFileDSConverter();
}

class TenkaLocalFileDSConverter
    extends TenkaDataSourceConverter<TenkaLocalFileDS> {
  @override
  final String type = 'local_file';

  TenkaLocalFileDS _fromStringifiedJson(final String data) {
    final Map<dynamic, dynamic> parsed =
        json.decode(data) as Map<dynamic, dynamic>;

    return TenkaLocalFileDS(
      root: path.dirname(parsed['root'] as String),
      file: path.basename(parsed['file'] as String),
    );
  }

  @override
  TenkaLocalFileDS fromTenkaDataSourceManifest(
    final TenkaDataSourceManifest manifest,
  ) {
    if (manifest.type != type) throw Exception('Invalid type');
    return _fromStringifiedJson(manifest.data);
  }

  TenkaLocalFileDS fromFullPath(final String fullPath) => TenkaLocalFileDS(
        root: path.dirname(fullPath),
        file: path.basename(fullPath),
      );

  String _toStringifiedJson(final TenkaLocalFileDS source) => json.encode(
        <dynamic, dynamic>{
          'root': source.root,
          'file': source.file,
        },
      );

  @override
  TenkaDataSourceManifest toTenkaDataSourceManifest(
    final TenkaLocalFileDS source,
  ) =>
      TenkaDataSourceManifest(type, _toStringifiedJson(source));

  static final TenkaLocalFileDSConverter converter =
      TenkaLocalFileDSConverter();
}
