import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'local_file.dart';
import '../model.dart';

class TenkaBase64DS extends EDataSource {
  TenkaBase64DS(this.data);

  factory TenkaBase64DS.fromEDataSourceJson(final TenkaDataSourceJson parsed) {
    if (parsed.type != type) throw Exception('Invalid type');
    return TenkaBase64DS(base64.decode(parsed.data));
  }

  final Uint8List data;

  Future<File> toLocalFile(final TenkaLocalFileDS local) async {
    final File file = File(local.fullPath);
    await file.writeAsBytes(data);

    return file;
  }

  @override
  TenkaDataSourceJson toEDataSourceJson() =>
      TenkaDataSourceJson(type, base64.encode(data));

  static const String type = 'base64';

  static Future<TenkaBase64DS> fromLocalFile(final ELocalFileDS local) async =>
      TenkaBase64DS(await File(local.fullPath).readAsBytes());
}
