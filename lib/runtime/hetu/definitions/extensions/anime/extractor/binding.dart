import 'package:extensions/models/exports.dart';
import 'package:hetu_script/binding.dart';
import 'package:hetu_script/hetu_script.dart';
import 'package:hetu_script/values.dart';
import './_parsers.dart';
import '../../../../model.dart';

class AnimeExtractorClassBinding extends HTExternalClass {
  AnimeExtractorClassBinding() : super('AnimeExtractor');

  @override
  dynamic memberGet(
    final String varName, {
    final String? from,
  }) {
    switch (varName) {
      case 'AnimeExtractor':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              AnimeExtractor(
            search: toSearch(namedArgs['search'] as HTFunction),
            getInfo: toGetInfo(namedArgs['getInfo'] as HTFunction),
            getSources: toGetSources(namedArgs['getSources'] as HTFunction),
          ),
        );

      default:
        throw HTError.undefined(varName);
    }
  }
}
