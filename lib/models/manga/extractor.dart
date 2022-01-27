import 'package:utilx/utilities/locale.dart';
import './chapter/info.dart';
import './info.dart';
import './page/info.dart';
import '../base/image_describer.dart';
import '../base/search/info.dart';

typedef GetMangaInfoFn = Future<MangaInfo> Function(String, Locale);

typedef GetChapterFn = Future<List<PageInfo>> Function(ChapterInfo);

typedef GetPageFn = Future<ImageDescriber> Function(PageInfo);

class MangaExtractor {
  const MangaExtractor({
    required final this.search,
    required final this.getInfo,
    required final this.getChapter,
    required final this.getPage,
  });

  final SearchFn search;
  final GetMangaInfoFn getInfo;
  final GetChapterFn getChapter;
  final GetPageFn getPage;
}
