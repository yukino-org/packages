import '../../model.dart';
import 'binding.dart';

final HetuHelperClass hLanguagesClass = HetuHelperClass(
  definition: LanguagesClassBinding(),
  declaration: '''
external class Languages {
  /// (string) => boolean
  static fun isValid(language);
  
  /// string[]
  static get all;
}
      '''
      .trim(),
);