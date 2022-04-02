import 'package:hetu_script/values.dart';
import 'package:tenka/tenka.dart';
import 'package:utilx/locale.dart';
import '../../../../model.dart';

SearchFn toSearch(final HTFunction fn) =>
    (final String terms, final Locale locale) async {
      final dynamic result =
          await fn.call(positionalArgs: <dynamic>[terms, locale]);

      return parseHetuReturnedList(result).cast<SearchInfo>();
    };

GetMangaInfoFn toGetInfo(final HTFunction fn) =>
    (final String url, final Locale locale) async {
      final dynamic result =
          await fn.call(positionalArgs: <dynamic>[url, locale]);

      return result as MangaInfo;
    };

GetChapterFn toGetChapter(final HTFunction fn) =>
    (final String url, final Locale locale) async {
      final dynamic result =
          await fn.call(positionalArgs: <dynamic>[url, locale]);

      return parseHetuReturnedList(result).cast<PageInfo>();
    };

GetPageFn toGetPage(final HTFunction fn) =>
    (final String url, final Locale locale) async {
      final dynamic result =
          await fn.call(positionalArgs: <dynamic>[url, locale]);

      return result as ImageDescriber;
    };
