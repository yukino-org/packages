import 'package:baize_compiler/baize_compiler.dart';
import 'package:tenka/tenka.dart';

abstract class TenkaCompiler {
  static Future<BaizeProgramConstant> compile(
    final TenkaLocalFileDS source,
  ) async {
    final BaizeProgramConstant program = await BaizeCompiler.compileProject(
      root: source.root,
      entrypoint: source.file,
    );
    return program;
  }
}
