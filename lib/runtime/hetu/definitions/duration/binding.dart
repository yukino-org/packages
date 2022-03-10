import 'package:hetu_script/binding.dart';
import 'package:hetu_script/hetu_script.dart';
import '../../model.dart';

class DurationClassBinding extends HTExternalClass {
  DurationClassBinding() : super('Duration');

  @override
  dynamic memberGet(
    final String varName, {
    final String? from,
    final bool error = true,
  }) {
    switch (varName) {
      case 'Duration':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Duration(
            days: namedArgs['days'] as int? ?? 0,
            hours: namedArgs['hours'] as int? ?? 0,
            minutes: namedArgs['minutes'] as int? ?? 0,
            seconds: namedArgs['seconds'] as int? ?? 0,
            milliseconds: namedArgs['milliseconds'] as int? ?? 0,
            microseconds: namedArgs['microseconds'] as int? ?? 0,
          ),
        );

      default:
        throw HTError.undefined(varName);
    }
  }

  @override
  dynamic instanceMemberGet(final dynamic object, final String varName) {
    final Duration element = object as Duration;

    switch (varName) {
      case 'inDays':
        return element.inDays;

      case 'inHours':
        return element.inHours;

      case 'inMinutes':
        return element.inMinutes;

      case 'inSeconds':
        return element.inSeconds;

      case 'inMilliseconds':
        return element.inMilliseconds;

      case 'inMicroseconds':
        return element.inMicroseconds;

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
