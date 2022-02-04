import 'dart:typed_data';
import 'package:hetu_script/hetu_script.dart';
import './manager.dart';

class ERuntimeInstanceOptions {
  const ERuntimeInstanceOptions({
    final this.hetuSourceContext,
  });

  final HTResourceContext<HTSource>? hetuSourceContext;
}

class ERuntimeInstance {
  ERuntimeInstance([this.options]);

  final ERuntimeInstanceOptions? options;

  late final Hetu hetu = Hetu(sourceContext: options?.hetuSourceContext);

  Future<void> loadScriptFile(
    final String path, {
    final bool globallyImport = true,
  }) async {
    if (options?.hetuSourceContext == null) {
      throw Exception('Not supported when `hetuSourceContext` is not provided');
    }

    await hetu.evalFile(path, globallyImport: globallyImport);
  }

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

  Future<Uint8List> compileScriptFile(final String path) async =>
      hetu.compileFile(path)!;

  Future<T> getExtractor<T>() async {
    final dynamic result = await hetu.eval(extractorIdentifier);
    return result as T;
  }

  static const String extractorIdentifier = 'extractor';
}
