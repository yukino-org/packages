import '../../model.dart';
import 'binding.dart';

final HetuHelperClass hConverterClass = HetuHelperClass(
  definition: ConverterClassBinding(),
  declaration: '''
external class Converter {
  /// (any) => string
  static fun jsonEncode(data);

  /// (string) => any
  static fun jsonDecode(data);

  /// (BytesContainer) => string
  static fun base64Encode(data);

  /// (string) => BytesContainer
  static fun base64Decode(data);

  /// (string) => BytesContainer
  static fun utf8Encode(data);

  /// (BytesContainer) => string
  static fun utf8Decode(data);

  /// (string) => BytesContainer
  static fun latin1Encode(data);

  /// (BytesContainer) => string
  static fun latin1Decode(data);

  /// (string) => int
  static fun codeUnitFromChar(char);

  /// (string) => List<int>
  static fun codeUnitsFromString(value);

  /// (int) => string
  static fun codeUnitToChar(codeUnit);

  /// (List<int>) => string
  static fun codeUnitsToString(codeUnits);
}
      '''
      .trim(),
);
