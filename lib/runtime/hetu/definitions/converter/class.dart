import 'dart:convert';
import 'bytes/class.dart';

class Converter {
  static String jsonEncode(final dynamic data) => json.encode(data);

  static dynamic jsonDecode(final String data) => json.decode(data);

  static String base64Encode(final BytesContainer data) =>
      base64.encode(data.list);

  static BytesContainer base64Decode(final String data) =>
      BytesContainer.fromList(base64.decode(data));

  static BytesContainer utf8Encode(final String data) =>
      BytesContainer.fromList(utf8.encode(data));

  static String utf8Decode(final BytesContainer data) => utf8.decode(data.list);

  static BytesContainer latin1Encode(final String data) =>
      BytesContainer.fromList(latin1.encode(data));

  static String latin1Decode(final BytesContainer data) =>
      latin1.decode(data.list);

  static int codeUnitFromChar(final String char) {
    if (char.length != 1) throw Exception('Must be a single character');
    return char.codeUnitAt(0);
  }

  static List<int> codeUnitsFromString(final String value) => value.codeUnits;

  static String codeUnitToChar(final int codeUnit) =>
      String.fromCharCode(codeUnit);

  static String codeUnitsToString(final List<int> codeUnits) =>
      String.fromCharCodes(codeUnits);
}
