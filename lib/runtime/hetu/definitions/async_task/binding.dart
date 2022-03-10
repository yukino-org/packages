import 'package:hetu_script/binding.dart';
import 'package:hetu_script/hetu_script.dart';
import 'package:hetu_script/value/function/function.dart';
import '../../model.dart';
import 'class.dart';

class AsyncTaskClassBinding extends HTExternalClass {
  AsyncTaskClassBinding() : super('AsyncTask');

  @override
  dynamic memberGet(
    final String varName, {
    final String? from,
    final bool error = true,
  }) {
    switch (varName) {
      case 'AsyncTask.resolve':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              AsyncTask.resolve(
            positionalArgs[0] as HTFunction,
            onDone: namedArgs['onDone'] as HTFunction,
            onFail: namedArgs['onFail'] as HTFunction?,
          ),
        );

      case 'AsyncTask.resolveAll':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              AsyncTask.resolveAll(
            (positionalArgs[0] as List<dynamic>).cast<HTFunction>(),
            onDone: namedArgs['onDone'] as HTFunction,
            onFail: namedArgs['onFail'] as HTFunction?,
          ),
        );

      case 'AsyncTask.wait':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              AsyncTask.wait(
            positionalArgs[0] as Duration,
            positionalArgs[1] as HTFunction,
          ),
        );

      default:
        throw HTError.undefined(varName);
    }
  }
}
