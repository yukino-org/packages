import 'package:extensions_runtime/extensions_runtime.dart';

export './base.dart';
export './resolvable.dart';
export './resolved.dart';

abstract class ExtensionInternals {
  static Future<void> initialize({
    required final ERuntimeOptions runtime,
  }) async {
    await ERuntimeManager.initialize(runtime);
  }

  static Future<void> dispose() async {
    await ERuntimeManager.dispose();
  }
}
