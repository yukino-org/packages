import 'package:beize_vm/beize_vm.dart';
import 'beize/helpers/http.dart';
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
    final BeizeProgramConstant program,
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
