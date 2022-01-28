import './binding.dart';
import '../../model.dart';

final HetuHelperClass hFlawClass = HetuHelperClass(
  definition: FlawClassBinding(),
  declaration: '''
external class Flaw {
  /// () => string
  fun toString();
  
  /// (any) => Flaw;
  fromUnknown(err);

  /// (Flaw | any) => never
  static fun throwFlaw(err);
}
      '''
      .trim(),
);
