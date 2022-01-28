import 'package:hetu_script/binding.dart';
import 'package:hetu_script/hetu_script.dart';
import './class.dart';
import '../../model.dart';

class FlawClassBinding extends HTExternalClass {
  FlawClassBinding() : super('Flaw');

  @override
  dynamic memberGet(
    final String varName, {
    final String? from,
    final bool error = true,
  }) {
    switch (varName) {
      case 'Flaw.fromUnknown':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Flaw.fromUnknown(positionalArgs[0]),
        );

      case 'Flaw.throwFlaw':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Flaw.throwFlaw(positionalArgs[0]),
        );

      default:
        throw HTError.undefined(varName);
    }
  }

  @override
  dynamic instanceMemberGet(final dynamic object, final String varName) {
    final Flaw element = object as Flaw;

    switch (varName) {
      case 'toString':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              element.toString(),
        );

      default:
        throw HTError.undefined(varName);
    }
  }
}
