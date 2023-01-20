import 'package:fubuki_compiler/fubuki_compiler.dart';
import 'package:tenka/tenka.dart';

abstract class TenkaCompiler {
  static Future<FubukiProgramConstant> compile(
    final TenkaLocalFileDS source,
  ) async {
    final FubukiProgramConstant program = await FubukiCompiler.compileProject(
      root: source.root,
      entrypoint: source.file,
    );
    return program;
  }
}
