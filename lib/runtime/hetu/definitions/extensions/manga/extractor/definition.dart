import './binding.dart';
import '../../../../model.dart';

final HetuHelperClass hMangaExtractorClass = HetuHelperClass(
  definition: MangaExtractorClassBinding(),
  declaration: '''
external class MangaExtractor {
  /// ({
  ///   defaultLocale: Locale,
  ///   search: (terms: string, locale: Locale) => DartFuture<List<SearchInfo>>,
  ///   getInfo: (url: string, locale: Locale) => DartFuture<MangaInfo>,
  ///   getChapter: (chapter: ChapterInfo) => DartFuture<List<PageInfo>>,
  ///   getPage: (page: PageInfo) => DartFuture<ImageDescriber>,
  /// }) => MangaExtractor;
  construct({ defaultLocale, search, getInfo, getChapter, getPage });
}
      '''
      .trim(),
);
