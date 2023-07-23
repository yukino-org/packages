import 'package:beize_vm/beize_vm.dart';
import 'package:tenka/tenka.dart';
import 'package:utilx/locale.dart';
import '../helpers/frame.dart';

class TenkaBeizeMangaExtractorConvertable
    extends TenkaBeizeConvertable<MangaExtractor> {
  TenkaBeizeMangaExtractorConvertable(super.converter);

  @override
  MangaExtractor convert(
    final BeizeCallFrame frame,
    final BeizeValue value,
  ) {
    final BeizePrimitiveObjectValue casted = value.cast();
    final BeizeValue defaultLocale =
        casted.getNamedProperty(TenkaBeizeConverter.kDefaultLocale);
    final BeizeFunctionValue search =
        casted.getNamedProperty(TenkaBeizeConverter.kSearch);
    final BeizeFunctionValue getInfo =
        casted.getNamedProperty(TenkaBeizeConverter.kGetInfo);
    final BeizeFunctionValue getChapter =
        casted.getNamedProperty(TenkaBeizeConverter.kGetChapter);
    final BeizeFunctionValue getPage =
        casted.getNamedProperty(TenkaBeizeConverter.kGetPage);

    return MangaExtractor(
      defaultLocale: converter.locale.convert(frame, defaultLocale),
      search: (final String terms, final Locale locale) async {
        final BeizeValue result = await frame.callValueAsyncUnwrapUnsafe(
          search,
          <BeizeValue>[
            BeizeStringValue(terms),
            BeizeStringValue(locale.toCodeString()),
          ],
        );
        return converter.searchInfo.convertMany(frame, result);
      },
      getInfo: (final String url, final Locale locale) async {
        final BeizeValue result = await frame.callValueAsyncUnwrapUnsafe(
          getInfo,
          <BeizeValue>[
            BeizeStringValue(url),
            BeizeStringValue(locale.toCodeString()),
          ],
        );
        return converter.mangaInfo.convert(frame, result);
      },
      getChapter: (final String url, final Locale locale) async {
        final BeizeValue result = await frame.callValueAsyncUnwrapUnsafe(
          getChapter,
          <BeizeValue>[
            BeizeStringValue(url),
            BeizeStringValue(locale.toCodeString()),
          ],
        );
        return converter.pageInfo.convertMany(frame, result);
      },
      getPage: (final String url, final Locale locale) async {
        final BeizeValue result = await frame.callValueAsyncUnwrapUnsafe(
          getPage,
          <BeizeValue>[
            BeizeStringValue(url),
            BeizeStringValue(locale.toCodeString()),
          ],
        );
        return converter.imageDescriber.convert(frame, result);
      },
    );
  }
}

extension TenkaBeizeMangaExtractorConverter on TenkaBeizeConverter {
  TenkaBeizeMangaExtractorConvertable get mangaExtractor =>
      TenkaBeizeMangaExtractorConvertable(this);
}
