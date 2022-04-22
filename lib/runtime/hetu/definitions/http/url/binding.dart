import 'package:hetu_script/binding.dart';
import 'package:hetu_script/hetu_script.dart';
import '../../../model.dart';
import 'class.dart';

class URLClassBinding extends HTExternalClass {
  URLClassBinding() : super('URL');

  @override
  dynamic memberGet(
    final String varName, {
    final String? from,
    final bool error = true,
  }) {
    switch (varName) {
      case 'URL.parse':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              URL.parse(positionalArgs[0] as String),
        );

      case 'URL.ensureScheme':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              URL.ensureScheme(
            positionalArgs[0] as String,
            scheme: (namedArgs[0] as String?) ?? URL.defaultEnsureScheme,
          ),
        );

      case 'URL.tryEncodeURL':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              URL.tryEncodeURL(positionalArgs[0] as String),
        );

      case 'URL.ensureURL':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              URL.ensureURL(positionalArgs[0] as String),
        );

      case 'URL.decodeComponent':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              URL.decodeComponent(positionalArgs[0] as String),
        );

      case 'URL.decodeQueryComponent':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              URL.decodeQueryComponent(positionalArgs[0] as String),
        );

      case 'URL.encodeComponent':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              URL.encodeComponent(positionalArgs[0] as String),
        );

      case 'URL.encodeFull':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              URL.encodeFull(positionalArgs[0] as String),
        );

      case 'URL.splitQueryString':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              URL.splitQueryString(positionalArgs[0] as String),
        );

      case 'URL.joinQueryParameters':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              URL.joinQueryParameters(
            parseHetuReturnedMap(positionalArgs[0]).cast<String, String>(),
          ),
        );

      default:
        throw HTError.undefined(varName);
    }
  }

  @override
  dynamic instanceMemberGet(final dynamic object, final String varName) {
    final URL element = object as URL;

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
