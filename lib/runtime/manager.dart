import 'package:hetu_script/hetu_script.dart';
import 'error.dart';
import 'hetu/exports.dart';
import 'hetu/helpers/http.dart';
import 'instance.dart';
import 'options.dart';

abstract class TenkaRuntimeManager {
  static int? _hetuDepLines;
  static bool ready = false;

  static Future<void> initialize(final TenkaRuntimeOptions options) async {
    if (ready) throw Exception('Cannot initialize twice');

    TenkaRuntimeHttpClient.initialize(options.http);

    ready = true;
  }

  static Future<TenkaRuntimeInstance> create([
    final TenkaRuntimeInstanceOptions? options,
  ]) async {
    if (!ready) throw Exception('Not ready');

    final TenkaRuntimeInstance instance = TenkaRuntimeInstance(options);

    instance.hetu.init(
      externalClasses: HetuHelperExports.externalClasses,
      externalFunctions: HetuHelperExports.externalFunctions,
    );

    return instance;
  }

  static String prependDefinitions(final String code) => '''
${HetuHelperExports.declarations}

$code
''';

  static TenkaRuntimeError modifyHTError(final HTError error) {
    _hetuDepLines ??=
        RegExp('\n').allMatches(prependDefinitions('')).length - 1;

    return TenkaRuntimeError(error: error, line: error.line! - _hetuDepLines!);
  }

  static Future<void> dispose() async {
    ready = false;
  }
}
