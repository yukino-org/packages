import 'dart:io';
import 'package:extensions/metadata.dart';
import './config.dart';
import '../environment.dart';

class ECompileAllOptions {
  const ECompileAllOptions({
    final this.outputDir,
    this.clearOutputDir = true,
    this.handleEnvironment = true,
  });

  final String? outputDir;
  final bool clearOutputDir;
  final bool handleEnvironment;

  ECompileOptions get compileOptions => ECompileOptions(
        outputDir: outputDir,
        handleEnvironment: false,
      );

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
      final Directory directory = Directory(options.outputDir!);

      if (await directory.exists()) {
        await directory.delete(recursive: true);
      }
    }

    final List<EMetadata> metadatas = await Future.wait(
      configs.map((final EConfig x) => x.compile(options.compileOptions)),
    );

    if (options.handleEnvironment) {
      await DTEnvironment.dispose();
    }

    return metadatas;
  }
}
