import 'dart:io';
import 'package:extensions/metadata.dart';
import './config.dart';
import '../environment.dart';

class ECompileAllOptions extends ECompileOptions {
  const ECompileAllOptions({
    this.clearOutputDir = true,
    final String? outputDir,
  }) : super(outputDir: outputDir, handleEnvironment: false);

  final bool clearOutputDir;

  static const ECompileAllOptions defaultOptions = ECompileAllOptions();
}

class EConfigRepository {
  const EConfigRepository(this.configs);

  final List<EConfig> configs;

  Future<List<EMetadata>> compileAll([
    final ECompileAllOptions options = ECompileAllOptions.defaultOptions,
  ]) async {
    if (options.handleEnvironment) {
      await DTEnvironment.prepare();
    }

    if (options.outputDir != null && options.clearOutputDir) {
      await Directory(options.outputDir!).delete(recursive: true);
    }

    final List<EMetadata> metadatas =
        await Future.wait(configs.map((final EConfig x) => x.compile(options)));

    if (options.handleEnvironment) {
      await DTEnvironment.dispose();
    }

    return metadatas;
  }
}
