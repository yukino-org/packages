import 'dart:typed_data';

import 'package:hetu_script/hetu_script.dart';
import './manager.dart';

class ERuntimeInstance {
  final Hetu hetu = Hetu();

  Future<void> loadScriptCode(
    final String code, {
    final bool appendDefinitions = false,
  }) async {
    await hetu.eval(
      appendDefinitions ? ERuntimeManager.prependDefinitions(code) : code,
    );
  }

  Future<void> loadByteCode(final Uint8List bytes) async {
    await hetu.loadBytecode(bytes: bytes, moduleName: extractorIdentifier);
  }

  Future<T> getExtractor<T>() async {
    final dynamic result = await hetu.eval(extractorIdentifier);
    return result as T;
  }

  static const String extractorIdentifier = 'extractor';
}
