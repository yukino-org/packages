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
    required final this.defaultLocale,
    required final this.search,
    required final this.getInfo,
    required final this.getChapter,
    required final this.getPage,
  });

  final Locale defaultLocale;
  final SearchFn search;
  final GetMangaInfoFn getInfo;
  final GetChapterFn getChapter;
  final GetPageFn getPage;
}