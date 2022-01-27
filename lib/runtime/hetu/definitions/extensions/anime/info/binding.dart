import 'package:extensions/models/exports.dart';
import 'package:hetu_script/binding.dart';
import 'package:hetu_script/hetu_script.dart';
import 'package:utilx/utilities/locale.dart';
import '../../../../model.dart';

class AnimeInfoClassBinding extends HTExternalClass {
  AnimeInfoClassBinding() : super('AnimeInfo');

  @override
  dynamic memberGet(
    final String varName, {
    final String? from,
  }) {
    switch (varName) {
      case 'AnimeInfo':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              AnimeInfo(
            title: namedArgs['title'] as String,
            url: namedArgs['url'] as String,
            episodes:
                (namedArgs['episodes'] as List<dynamic>).cast<EpisodeInfo>(),
            locale: namedArgs['locale'] as Locale,
            availableLocales:
                (namedArgs['availableLocales'] as List<dynamic>).cast<Locale>(),
            thumbnail: namedArgs['thumbnail'] as ImageDescriber?,
          ),
        );

      default:
        throw HTError.undefined(varName);
    }
  }

  @override
  dynamic instanceMemberGet(final dynamic object, final String varName) {
    final AnimeInfo element = object as AnimeInfo;

    switch (varName) {
      case 'title':
        return element.title;

      case 'url':
        return element.url;

      case 'episodes':
        return element.episodes;

      case 'locale':
        return element.locale.toCodeString();

      case 'availableLocales':
        return element.availableLocales
            .map((final Locale x) => x.toCodeString())
            .toList();

      case 'thumbnail':
        return element.thumbnail;

      case 'toJson':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              element.toJson(),
        );

      default:
        throw HTError.undefined(varName);
    }
  }
}
