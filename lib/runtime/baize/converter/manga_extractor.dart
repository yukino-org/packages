import 'package:baize_vm/baize_vm.dart';
import 'package:tenka/tenka.dart';
import 'package:utilx/locale.dart';

class TenkaBaizeMangaExtractorConvertable
    extends TenkaBaizeConvertable<MangaExtractor> {
  TenkaBaizeMangaExtractorConvertable(super.converter);

  @override
  MangaExtractor convert(
    final BaizeCallFrame frame,
    final BaizeValue value,
  ) {
    final BaizePrimitiveObjectValue casted = value.cast();
    final BaizeValue defaultLocale =
        casted.getNamedProperty(TenkaBaizeConverter.kDefaultLocale);
    final BaizeFunctionValue search =
        casted.getNamedProperty(TenkaBaizeConverter.kSearch);
    final BaizeFunctionValue getInfo =
        casted.getNamedProperty(TenkaBaizeConverter.kGetInfo);
    final BaizeFunctionValue getChapter =
        casted.getNamedProperty(TenkaBaizeConverter.kGetChapter);
    final BaizeFunctionValue getPage =
        casted.getNamedProperty(TenkaBaizeConverter.kGetPage);

    return MangaExtractor(
      defaultLocale: converter.locale.convert(frame, defaultLocale),
      search: (final String terms, final Locale locale) async {
        final BaizeValue result = await frame.callValue(
          search,
          <BaizeValue>[
            BaizeStringValue(terms),
            BaizeStringValue(locale.toCodeString()),
          ],
        ).unwrapUnsafe();
        return converter.searchInfo.convertMany(frame, result);
      },
      getInfo: (final String url, final Locale locale) async {
        final BaizeValue result = await frame.callValue(
          getInfo,
          <BaizeValue>[
            BaizeStringValue(url),
            BaizeStringValue(locale.toCodeString()),
          ],
        ).unwrapUnsafe();
        return converter.mangaInfo.convert(frame, result);
      },
      getChapter: (final String url, final Locale locale) async {
        final BaizeValue result = await frame.callValue(
          getChapter,
          <BaizeValue>[
            BaizeStringValue(url),
            BaizeStringValue(locale.toCodeString()),
          ],
        ).unwrapUnsafe();
        return converter.pageInfo.convertMany(frame, result);
      },
      getPage: (final String url, final Locale locale) async {
        final BaizeValue result = await frame.callValue(
          getPage,
          <BaizeValue>[
            BaizeStringValue(url),
            BaizeStringValue(locale.toCodeString()),
          ],
        ).unwrapUnsafe();
        return converter.imageDescriber.convert(frame, result);
      },
    );
  }
}

extension TenkaBaizeMangaExtractorConverter on TenkaBaizeConverter {
  TenkaBaizeMangaExtractorConvertable get mangaExtractor =>
      TenkaBaizeMangaExtractorConvertable(this);
}
