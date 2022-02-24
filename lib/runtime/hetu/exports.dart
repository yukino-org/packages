import 'package:hetu_script/binding.dart';
import 'definitions/async_task/definition.dart';
import 'definitions/clock/definition.dart';
import 'definitions/collection/definition.dart';
import 'definitions/converter/bytes/definition.dart';
import 'definitions/converter/definition.dart';
import 'definitions/crypto/definition.dart';
import 'definitions/fuzzy/definition.dart';
import 'definitions/fuzzy/key/definition.dart';
import 'definitions/fuzzy/result_item/definition.dart';
import 'definitions/html/definition.dart';
import 'definitions/http/definition.dart';
import 'definitions/http/result/definition.dart';
import 'definitions/languages/definition.dart';
import 'definitions/regex/definition.dart';
import 'definitions/regex/match/definition.dart';
import 'definitions/string/format/definition.dart';
import 'definitions/tenka/anime/episode/info/definition.dart';
import 'definitions/tenka/anime/episode/source/definition.dart';
import 'definitions/tenka/anime/extractor/definition.dart';
import 'definitions/tenka/anime/info/definition.dart';
import 'definitions/tenka/base/image_describer/definition.dart';
import 'definitions/tenka/base/locale/definition.dart';
import 'definitions/tenka/base/search/info/definition.dart';
import 'definitions/tenka/manga/chapter/info/definition.dart';
import 'definitions/tenka/manga/extractor/definition.dart';
import 'definitions/tenka/manga/info/definition.dart';
import 'definitions/tenka/manga/page/info/definition.dart';
import 'definitions/webview/definition.dart';
import 'model.dart';

abstract class HetuHelperExports {
  static final List<HetuHelperClass> classes = <HetuHelperClass>[
    hAsyncTaskClass,
    hClockClass,
    hCollectionClass,
    hBytesContainerClass,
    hConverterClass,
    hCryptoClass,
    hEpisodeInfoClass,
    hEpisodeSourceClass,
    hAnimeExtractorClass,
    hAnimeInfoClass,
    hImageDescriberClass,
    hLocaleClass,
    hSearchInfoClass,
    hChapterInfoClass,
    hMangaExtractorClass,
    hMangaInfoClass,
    hPageInfoClass,
    hFuzzySearchClass,
    hFuzzySearchKeyClass,
    hFuzzySearchResultItemClass,
    hHtmlElementClass,
    hHttpClass,
    hHttpResponseClass,
    hLanguagesClass,
    hRegexClass,
    hRegexMatchClass,
    hWebviewClass,
  ];

  static final List<HetuHelperFunction> functions = <HetuHelperFunction>[
    hStrFmtFunction,
  ];

  static List<HTExternalClass> get externalClasses =>
      classes.map((final HetuHelperClass x) => x.definition).toList();

  static Map<String, Function> get externalFunctions => functions.asMap().map(
        (final int i, final HetuHelperFunction x) =>
            MapEntry<String, Function>(x.name, x.definition),
      );

  static String get declarations => <String>[
        ...classes.map((final HetuHelperClass x) => x.declaration),
        ...functions.map((final HetuHelperFunction x) => x.declaration),
      ].join('\n');
}
