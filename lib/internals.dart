import 'package:tenka_runtime/tenka_runtime.dart';

abstract class TenkaInternals {
  static bool isDebug = false;

  static Future<void> initialize({
    required final TenkaRuntimeOptions runtime,
    final bool? isDebug,
  }) async {
    await TenkaRuntimeManager.initialize(runtime);
    TenkaInternals.isDebug = isDebug ?? TenkaInternals.isDebug;
  }

  static Future<void> dispose() async {
    await TenkaRuntimeManager.dispose();
  }
}
