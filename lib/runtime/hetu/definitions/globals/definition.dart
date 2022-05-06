import '../../model.dart';
import 'binding.dart';

final HetuHelperClass hGlobalsClass = HetuHelperClass(
  definition: GlobalsClassBinding(),
  declaration: '''
external class Globals {
  /// bool
  static get isDebug;
}
      '''
      .trim(),
);
