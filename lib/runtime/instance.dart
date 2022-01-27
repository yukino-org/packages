import 'dart:typed_data';
import 'package:hetu_script/hetu_script.dart';

const String _extractorIdentifier = 'extractor';

class ERuntimeInstance {
  final Hetu hetu = Hetu();

  Future<void> loadByteCode(final Uint8List bytes) async {
    // TODO: fix `moduleName`
    hetu.loadBytecode(bytes: bytes, moduleName: _extractorIdentifier);
  }

  Future<T> getExtractor<T>() async {
    final dynamic result = await hetu.eval(_extractorIdentifier);
    return result as T;
  }
}
