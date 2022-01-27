import 'package:extensions/models/exports.dart';
import 'package:hetu_script/binding.dart';
import 'package:hetu_script/hetu_script.dart';
import 'package:utilx/utilities/locale.dart';
import '../../../../model.dart';

class MangaInfoClassBinding extends HTExternalClass {
  MangaInfoClassBinding() : super('MangaInfo');

  @override
  dynamic memberGet(
    final String varName, {
    final String? from,
  }) {
    switch (varName) {
      case 'MangaInfo':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              MangaInfo(
            title: namedArgs['title'] as String,
            url: namedArgs['url'] as String,
            chapters:
                (namedArgs['chapters'] as List<dynamic>).cast<ChapterInfo>(),
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
    final MangaInfo element = object as MangaInfo;

    switch (varName) {
      case 'title':
        return element.title;

      case 'url':
        return element.url;

      case 'chapters':
        return element.chapters;

      case 'locale':
        return element.locale;

      case 'availableLocales':
        return element.availableLocales.map((final Locale x) => x).toList();

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
