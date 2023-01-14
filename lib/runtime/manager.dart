import 'package:fubuki_vm/fubuki_vm.dart';
import 'fubuki/helpers/http.dart';
import 'instance.dart';
import 'options.dart';

abstract class TenkaRuntimeManager {
  static bool ready = false;

  static Future<void> initialize(final TenkaRuntimeOptions options) async {
    if (ready) throw Exception('Cannot initialize twice');
    TenkaRuntimeHttpClient.initialize(options.http);
    ready = true;
  }

  static Future<TenkaRuntimeInstance> create(
    final FubukiProgramConstant program,
  ) async {
    if (!ready) throw Exception('Not ready');
    final TenkaRuntimeInstance instance = TenkaRuntimeInstance(program);
    await instance.initialize();
    return instance;
  }

  static Future<void> dispose() async {
    ready = false;
  }
}
