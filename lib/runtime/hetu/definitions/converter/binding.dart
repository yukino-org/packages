import 'package:hetu_script/binding.dart';
import 'package:hetu_script/hetu_script.dart';
import '../../model.dart';
import 'bytes/class.dart';
import 'class.dart';

class ConverterClassBinding extends HTExternalClass {
  ConverterClassBinding() : super('Converter');

  @override
  dynamic memberGet(
    final String varName, {
    final String? from,
    final bool error = true,
  }) {
    switch (varName) {
      case 'Converter.jsonEncode':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Converter.jsonEncode(positionalArgs[0]),
        );

      case 'Converter.jsonDecode':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Converter.jsonDecode(positionalArgs[0] as String),
        );

      case 'Converter.utf8Encode':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Converter.utf8Encode(positionalArgs[0] as String),
        );

      case 'Converter.utf8Decode':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Converter.utf8Decode(positionalArgs[0] as BytesContainer),
        );

      case 'Converter.base64Encode':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Converter.base64Encode(positionalArgs[0] as BytesContainer),
        );

      case 'Converter.base64Decode':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Converter.base64Decode(positionalArgs[0] as String),
        );

      case 'Converter.latin1Encode':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Converter.latin1Encode(positionalArgs[0] as String),
        );

      case 'Converter.latin1Decode':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Converter.latin1Decode(positionalArgs[0] as BytesContainer),
        );

      case 'Converter.codeUnitFromChar':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Converter.codeUnitFromChar(positionalArgs[0] as String),
        );

      case 'Converter.codeUnitsFromString':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Converter.codeUnitsFromString(positionalArgs[0] as String),
        );

      case 'Converter.codeUnitToChar':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Converter.codeUnitToChar(positionalArgs[0] as int),
        );

      case 'Converter.codeUnitsToString':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Converter.codeUnitsToString(
            parseHetuReturnedList(positionalArgs[0]).cast<int>(),
          ),
        );

      default:
        throw HTError.undefined(varName);
    }
  }
}
