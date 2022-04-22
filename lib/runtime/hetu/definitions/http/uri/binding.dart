import 'package:hetu_script/binding.dart';
import 'package:hetu_script/hetu_script.dart';
import '../../../model.dart';
import 'class.dart';

class UriClassBinding extends HTExternalClass {
  UriClassBinding() : super('Uri');

  @override
  dynamic memberGet(
    final String varName, {
    final String? from,
    final bool error = true,
  }) {
    switch (varName) {
      case 'Uri.parse':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              HetuUri.parse(positionalArgs[0] as String),
        );

      case 'Uri.ensureScheme':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              HetuUri.ensureScheme(
            positionalArgs[0] as String,
            scheme: (namedArgs[0] as String?) ?? HetuUri.defaultEnsureScheme,
          ),
        );

      case 'Uri.tryEncodeURL':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              HetuUri.tryEncodeURL(positionalArgs[0] as String),
        );

      case 'Uri.ensureURL':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              HetuUri.ensureURL(positionalArgs[0] as String),
        );

      case 'Uri.decodeComponent':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              HetuUri.decodeComponent(positionalArgs[0] as String),
        );

      case 'Uri.decodeQueryComponent':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              HetuUri.decodeQueryComponent(positionalArgs[0] as String),
        );

      case 'Uri.encodeComponent':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              HetuUri.encodeComponent(positionalArgs[0] as String),
        );

      case 'Uri.encodeFull':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              HetuUri.encodeFull(positionalArgs[0] as String),
        );

      case 'Uri.splitQueryString':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              HetuUri.splitQueryString(positionalArgs[0] as String),
        );

      case 'Uri.joinQueryParameters':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              HetuUri.joinQueryParameters(
            parseHetuReturnedMap(positionalArgs[0]).cast<String, String>(),
          ),
        );

      default:
        throw HTError.undefined(varName);
    }
  }

  @override
  dynamic instanceMemberGet(final dynamic object, final String varName) {
    final HetuUri element = object as HetuUri;

    switch (varName) {
      case 'hasAbsolutePath':
        return element.hasAbsolutePath;

      case 'hasAuthority':
        return element.hasAuthority;

      case 'hasEmptyPath':
        return element.hasEmptyPath;

      case 'hasFragment':
        return element.hasFragment;

      case 'hasPort':
        return element.hasPort;

      case 'hasQuery':
        return element.hasQuery;

      case 'hasScheme':
        return element.hasScheme;

      case 'isAbsolute':
        return element.isAbsolute;

      case 'authority':
        return element.authority;

      case 'host':
        return element.host;

      case 'origin':
        return element.origin;

      case 'port':
        return element.port;

      case 'path':
        return element.path;

      case 'pathSegments':
        return element.pathSegments;

      case 'fragment':
        return element.fragment;

      case 'query':
        return element.query;

      case 'queryParameters':
        return element.queryParameters;

      case 'queryParametersAll':
        return element.queryParametersAll;

      case 'scheme':
        return element.scheme;

      case 'isScheme':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              element.isScheme(positionalArgs[0] as String),
        );

      case 'normalizePath':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              element.normalizePath(),
        );

      case 'removeFragment':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              element.removeFragment(),
        );

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
