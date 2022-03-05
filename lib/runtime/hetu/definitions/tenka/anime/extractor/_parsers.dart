import 'package:hetu_script/values.dart';
import 'package:tenka/tenka.dart';
import 'package:utilx/locale.dart';

SearchFn toSearch(final HTFunction fn) =>
    (final String terms, final Locale locale) async {
      final dynamic result =
          await fn.call(positionalArgs: <dynamic>[terms, locale]);

      return (result as List<dynamic>).cast<SearchInfo>();
    };

GetAnimeInfoFn toGetInfo(final HTFunction fn) =>
    (final String url, final Locale locale) async {
      final dynamic result =
          await fn.call(positionalArgs: <dynamic>[url, locale]);

      return result as AnimeInfo;
    };

GetSourcesFn toGetSources(final HTFunction fn) =>
    (final String url, final Locale locale) async {
      final dynamic result =
          await fn.call(positionalArgs: <dynamic>[url, locale]);

      return (result as List<dynamic>).cast<EpisodeSource>();
    };
