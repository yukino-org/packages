import 'package:utilx/utilities/locale.dart';
import './episode/info.dart';
import './episode/source.dart';
import './info.dart';
import '../base/search/info.dart';

typedef GetAnimeInfoFn = Future<AnimeInfo> Function(String, Locale);

typedef GetSourcesFn = Future<List<EpisodeSource>> Function(EpisodeInfo);

class AnimeExtractor {
  const AnimeExtractor({
    required final this.search,
    required final this.getInfo,
    required final this.getSources,
  });

  final GetSearchInfosFn search;
  final GetAnimeInfoFn getInfo;
  final GetSourcesFn getSources;
}
