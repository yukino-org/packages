import 'package:hetu_script/hetu_script.dart';
import 'package:utilx/utilities/webview/webview.dart';
import './error.dart';
import './hetu/exports.dart';
import './hetu/helpers/http.dart';
import './instance.dart';
import './options.dart';

abstract class ERuntimeManager {
  static int? _hetuDepLines;
  static bool ready = false;

  static Future<void> initialize(final ERuntimeOptions options) async {
    HetuHttpClient.initialize(options.http);
    await WebviewManager.initialize(options.webview);

    ready = true;
  }

  static Future<ERuntimeInstance> create() async {
    if (!ready) throw Error();

    final ERuntimeInstance instance = ERuntimeInstance();

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

  static ERuntimeError modifyHTError(final HTError error) {
    _hetuDepLines ??=
        RegExp('\n').allMatches(prependDefinitions('')).length - 1;

    return ERuntimeError(error: error, line: error.line! - _hetuDepLines!);
  }

  static Future<void> dispose() async {
    await WebviewManager.dispose();

    ready = false;
  }
}
