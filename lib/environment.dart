import 'package:tenka/tenka.dart';
import 'utils/exports.dart';

abstract class TenkaDevEnvironment {
  static Future<void> prepare() async {
    await TenkaInternals.initialize(
      runtime: const TenkaRuntimeOptions(
        http: TenkaRuntimeHttpClientOptions(ignoreSSLCertificate: true),
      ),
      isDebug: true,
    );
  }

  static Future<void> dispose() async {
    await TenkaInternals.dispose();
  }

  static Future<void> middleware(final VoidFutureCallback fn) async {
    await prepare();
    await fn();
    await dispose();
  }
}
