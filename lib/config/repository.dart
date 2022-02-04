import 'package:extensions/metadata.dart';
import './config.dart';

class EConfigRepository {
  const EConfigRepository(this.configs);

  final List<EConfig> configs;

  Future<List<EMetadata>> compileAll([final String? outputDir]) async =>
      Future.wait(configs.map((final EConfig x) => x.compile(outputDir)));
}
