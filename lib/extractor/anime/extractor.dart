import 'package:utilx/locale.dart';
import '../base/search/info.dart';
import 'episode/source.dart';
import 'info.dart';

typedef GetAnimeInfoFn = Future<AnimeInfo> Function(String, Locale);

typedef GetSourcesFn = Future<EpisodeSource> Function(String, Locale);

class AnimeExtractor {
  const AnimeExtractor({
    required this.defaultLocale,
    required this.search,
    required this.getInfo,
    required this.getSources,
  });

  final Locale defaultLocale;
  final SearchFn search;
  final GetAnimeInfoFn getInfo;
  final GetSourcesFn getSources;
}
