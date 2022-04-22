import 'package:hetu_script/binding.dart';
import 'package:hetu_script/hetu_script.dart';
import 'package:hetu_script/values.dart';
import '../../model.dart';
import 'class.dart';

class CollectionClassBinding extends HTExternalClass {
  CollectionClassBinding() : super('Collection');

  @override
  dynamic memberGet(
    final String varName, {
    final String? from,
    final bool error = true,
  }) {
    switch (varName) {
      case 'Collection.rangeList':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Collection.rangeList(
            positionalArgs[0] as int,
            positionalArgs[1] as int,
          ),
        );

      case 'Collection.filledList':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Collection.filledList(
            positionalArgs[0] as int,
            positionalArgs[1],
          ),
        );

      case 'Collection.mergeList':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Collection.mergeList(
            parseHetuReturnedList(positionalArgs[0]),
            parseHetuReturnedList(positionalArgs[1]),
          ),
        );

      case 'Collection.eachList':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Collection.eachList(
            parseHetuReturnedList(positionalArgs[0]),
            positionalArgs[1] as HTFunction,
          ),
        );

      case 'Collection.mapList':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Collection.mapList(
            parseHetuReturnedList(positionalArgs[0]),
            positionalArgs[1] as HTFunction,
          ),
        );

      case 'Collection.filterList':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Collection.filterList(
            parseHetuReturnedList(positionalArgs[0]),
            positionalArgs[1] as HTFunction,
          ),
        );

      case 'Collection.findList':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Collection.findList(
            parseHetuReturnedList(positionalArgs[0]),
            positionalArgs[1] as HTFunction,
          ),
        );

      case 'Collection.flattenList':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Collection.flattenList(
            parseHetuReturnedList(positionalArgs[0]),
            positionalArgs[1] as int,
          ),
        );

      case 'Collection.deepFlattenList':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Collection.deepFlattenList(
            parseHetuReturnedList(positionalArgs[0]),
          ),
        );

      case 'Collection.mergeMap':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Collection.mergeMap(
            parseHetuReturnedMap(positionalArgs[0]),
            parseHetuReturnedMap(positionalArgs[1]),
          ),
        );

      case 'Collection.eachMap':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Collection.eachMap(
            parseHetuReturnedMap(positionalArgs[0]),
            positionalArgs[1] as HTFunction,
          ),
        );

      case 'Collection.mapToList':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Collection.mapToList(
            parseHetuReturnedMap(positionalArgs[0]),
          ),
        );

      case 'Collection.repeatUntil':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Collection.repeatUntil(
            positionalArgs[0] as HTFunction,
          ),
        );

      case 'Collection.uniqueList':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Collection.uniqueList(parseHetuReturnedList(positionalArgs[0])),
        );

      default:
        throw HTError.undefined(varName);
    }
  }
}
