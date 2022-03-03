import 'package:tenka_runtime/tenka_runtime.dart';

abstract class TenkaInternals {
  static Future<void> initialize({
    required final TenkaRuntimeOptions runtime,
  }) async {
    await TenkaRuntimeManager.initialize(runtime);
  }

  static Future<void> dispose() async {
    await TenkaRuntimeManager.dispose();
  }
}
