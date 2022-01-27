import 'package:extensions/models/exports.dart';
import 'package:hetu_script/binding.dart';
import 'package:hetu_script/hetu_script.dart';
import 'package:hetu_script/values.dart';
import 'package:utilx/utilities/locale.dart';
import './_parsers.dart';
import '../../../../model.dart';

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
            getChapter: toGetChapter(namedArgs['getSources'] as HTFunction),
            getPage: toGetPage(namedArgs['getSources'] as HTFunction),
          ),
        );

      default:
        throw HTError.undefined(varName);
    }
  }
}
