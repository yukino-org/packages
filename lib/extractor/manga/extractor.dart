import 'package:utilx/locale.dart';
import '../base/image_describer.dart';
import '../base/search/info.dart';
import 'info.dart';
import 'page/info.dart';

typedef GetMangaInfoFn = Future<MangaInfo> Function(String, Locale);

typedef GetChapterFn = Future<List<PageInfo>> Function(String, Locale);

typedef GetPageFn = Future<ImageDescriber> Function(String, Locale);

class MangaExtractor {
  const MangaExtractor({
    required this.defaultLocale,
    required this.search,
    required this.getInfo,
    required this.getChapter,
    required this.getPage,
  });

  final Locale defaultLocale;
  final SearchFn search;
  final GetMangaInfoFn getInfo;
  final GetChapterFn getChapter;
  final GetPageFn getPage;
}
