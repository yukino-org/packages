import './binding.dart';
import '../../../../model.dart';

final HetuHelperClass hAnimeExtractorClass = HetuHelperClass(
  definition: AnimeExtractorClassBinding(),
  declaration: '''
external class AnimeExtractor {
  /// ({
  ///   defaultLocale: Locale,
  ///   search: (terms: string, locale: Locale) => DartFuture<List<SearchInfo>>,
  ///   getInfo: (url: string, locale: Locale) => DartFuture<AnimeInfo>,
  ///   getSources: (episode: EpisodeInfo) => DartFuture<List<EpisodeSources>>,
  /// }) => AnimeExtractor;
  construct({ defaultLocale, search, getInfo, getSources });
}
      '''
      .trim(),
);
