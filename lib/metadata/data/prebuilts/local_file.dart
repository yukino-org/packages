import 'dart:convert';
import 'package:path/path.dart' as path;
import '../model.dart';

class TenkaLocalFileDS extends EDataSource {
  TenkaLocalFileDS({
    required this.root,
    required this.file,
  });

  factory TenkaLocalFileDS._fromStringifiedJson(final String data) {
    final Map<dynamic, dynamic> parsed =
        json.decode(data) as Map<dynamic, dynamic>;

    return TenkaLocalFileDS(
      root: path.dirname(parsed['root'] as String),
      file: path.basename(parsed['file'] as String),
    );
  }

  factory TenkaLocalFileDS.fromFullPath(final String fullPath) => ELocalFileDS(
        root: path.dirname(fullPath),
        file: path.basename(fullPath),
      );

  factory TenkaLocalFileDS.fromEDataSourceJson(final EDataSourceJson parsed) {
    if (parsed.type != type) throw Exception('Invalid type');
    return TenkaLocalFileDS._fromStringifiedJson(parsed.data);
  }

  final String root;
  final String file;

  String _toStringifiedJson() => json.encode(
        <dynamic, dynamic>{
          'root': root,
          'file': file,
        },
      );

  @override
  TenkaDataSourceJson toTenkaDataSourceJson() =>
      TenkaDataSourceJson(type, _toStringifiedJson());

  String get fullPath => path.join(root, file);

  static const String type = 'local_file';
}
