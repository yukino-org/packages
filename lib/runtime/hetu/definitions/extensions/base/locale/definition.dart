import './binding.dart';
import '../../../../model.dart';

final HetuHelperClass hLocaleClass = HetuHelperClass(
  definition: LocaleClassBinding(),
  declaration: '''
external class Locale {  
  /// string
  get code;

  /// string
  get language;
  
  /// string?
  get countryCode;
  
  /// string?
  get country;

  /// () => string
  fun toCodeString();

  /// () => string
  fun toPrettyString();

  /// () => Map<dynamic, dynamic>
  fun toJson();

  /// (string) => Locale
  static fun parse(code);
}
      '''
      .trim(),
);
