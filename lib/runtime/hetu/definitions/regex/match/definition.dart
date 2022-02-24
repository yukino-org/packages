import '../../../model.dart';
import 'binding.dart';

final HetuHelperClass hRegexMatchClass = HetuHelperClass(
  definition: RegexMatchClassBinding(),
  declaration: '''
external class RegexMatch {
  /// string
  final input;
  
  /// (int) => string?
  fun group(group);
}
      '''
      .trim(),
);
