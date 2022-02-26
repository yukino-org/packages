import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import '../model.dart';
import 'local_file.dart';

class TenkaBase64DS extends TenkaDataSource {
  TenkaBase64DS(this.data);

  final Uint8List data;

  Future<File> toLocalFile(final TenkaLocalFileDS local) async {
    final File file = File(local.fullPath);
    await file.writeAsBytes(data);

    return file;
  }

  @override
  TenkaDataSourceConverter<dynamic> get converter => TenkaBase64DSConverter();
}

class TenkaBase64DSConverter extends TenkaDataSourceConverter<TenkaBase64DS> {
  @override
  final String type = 'base64';

  @override
  TenkaBase64DS fromTenkaDataSourceManifest(
    final TenkaDataSourceManifest manifest,
  ) {
    if (manifest.type != type) throw Exception('Invalid type');
    return TenkaBase64DS(base64.decode(manifest.data));
  }

  Future<TenkaBase64DS> fromLocalFile(
    final TenkaLocalFileDS local,
  ) async =>
      TenkaBase64DS(await File(local.fullPath).readAsBytes());

  @override
  TenkaDataSourceManifest toTenkaDataSourceManifest(
    final TenkaBase64DS source,
  ) =>
      TenkaDataSourceManifest(type, base64.encode(source.data));

  static final TenkaBase64DSConverter converter = TenkaBase64DSConverter();
}
