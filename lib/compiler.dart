import 'package:beize_compiler/beize_compiler.dart';
import 'package:tenka/tenka.dart';

abstract class TenkaCompiler {
  static Future<BeizeProgramConstant> compile(
    final TenkaLocalFileDS source, {
    final bool disablePrint = false,
  }) async {
    final BeizeProgramConstant program = await BeizeCompiler.compileProject(
      root: source.root,
      entrypoint: source.file,
      options: BeizeCompilerOptions(disablePrint: disablePrint),
    );
    return program;
  }
}
