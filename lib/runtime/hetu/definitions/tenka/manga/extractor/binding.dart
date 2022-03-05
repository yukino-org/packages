import 'package:hetu_script/binding.dart';
import 'package:hetu_script/hetu_script.dart';
import 'package:hetu_script/values.dart';
import 'package:tenka/tenka.dart';
import 'package:utilx/locale.dart';
import '../../../../model.dart';
import '_parsers.dart';

class MangaExtractorClassBinding extends HTExternalClass {
  MangaExtractorClassBinding() : super('MangaExtractor');

  @override
  dynamic memberGet(
    final String varName, {
    final String? from,
  }) {
    switch (varName) {
      case 'MangaExtractor':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              MangaExtractor(
            defaultLocale: namedArgs['defaultLocale'] as Locale,
            search: toSearch(namedArgs['search'] as HTFunction),
            getInfo: toGetInfo(namedArgs['getInfo'] as HTFunction),
            getChapter: toGetChapter(namedArgs['getChapter'] as HTFunction),
            getPage: toGetPage(namedArgs['getPage'] as HTFunction),
          ),
        );

      default:
        throw HTError.undefined(varName);
    }
  }
}
