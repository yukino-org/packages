import 'package:utilx/utilities/locale.dart';
import '../base/search/info.dart';
import 'episode/source.dart';
import 'info.dart';

typedef GetAnimeInfoFn = Future<AnimeInfo> Function(String, Locale);

typedef GetSourcesFn = Future<List<EpisodeSource>> Function(String, Locale);

class AnimeExtractor {
  const AnimeExtractor({
    required final this.defaultLocale,
    required final this.search,
    required final this.getInfo,
    required final this.getSources,
  });

  final Locale defaultLocale;
  final SearchFn search;
  final GetAnimeInfoFn getInfo;
  final GetSourcesFn getSources;
}
