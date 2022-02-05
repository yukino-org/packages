import 'package:extensions/metadata.dart';
import './config.dart';
import '../environment.dart';

class EConfigRepository {
  const EConfigRepository(this.configs);

  final List<EConfig> configs;

  Future<List<EMetadata>> compileAll([
    final ECompileOptions options = ECompileOptions.defaultOptions,
  ]) async {
    if (options.handleEnvironment) {
      await DTEnvironment.prepare();
    }

    final ECompileOptions compileOptions = ECompileOptions(
      outputDir: options.outputDir,
      handleEnvironment: false,
    );

    final List<EMetadata> metadatas = await Future.wait(
      configs.map((final EConfig x) => x.compile(compileOptions)),
    );

    if (options.handleEnvironment) {
      await DTEnvironment.dispose();
    }

    return metadatas;
  }
}
