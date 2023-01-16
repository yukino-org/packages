import 'package:fubuki_vm/fubuki_vm.dart';
import 'package:tenka/tenka.dart';
import 'package:utilx/locale.dart';

class TenkaFubukiMangaExtractorConvertable
    extends TenkaFubukiConvertable<MangaExtractor> {
  TenkaFubukiMangaExtractorConvertable(super.converter);

  @override
  MangaExtractor convert(
    final FubukiCallFrame frame,
    final FubukiValue value,
  ) {
    final FubukiPrimitiveObjectValue casted = value.cast();
    final FubukiValue defaultLocale =
        casted.getNamedProperty(TenkaFubukiConverter.kDefaultLocale);
    final FubukiFunctionValue search =
        casted.getNamedProperty(TenkaFubukiConverter.kSearch);
    final FubukiFunctionValue getInfo =
        casted.getNamedProperty(TenkaFubukiConverter.kGetInfo);
    final FubukiFunctionValue getChapter =
        casted.getNamedProperty(TenkaFubukiConverter.kGetChapter);
    final FubukiFunctionValue getPage =
        casted.getNamedProperty(TenkaFubukiConverter.kGetPage);

    return MangaExtractor(
      defaultLocale: converter.locale.convert(frame, defaultLocale),
      search: (final String terms, final Locale locale) async {
        final FubukiValue value = await frame.callValue(
          search,
          <FubukiValue>[
            FubukiStringValue(terms),
            FubukiStringValue(locale.toCodeString()),
          ],
        ).unwrapUnsafe();
        final FubukiValue result = await value.awaited();
        return converter.searchInfo.convertMany(frame, result);
      },
      getInfo: (final String url, final Locale locale) async {
        final FubukiValue value = await frame.callValue(
          getInfo,
          <FubukiValue>[
            FubukiStringValue(url),
            FubukiStringValue(locale.toCodeString()),
          ],
        ).unwrapUnsafe();
        final FubukiValue result = await value.awaited();
        return converter.mangaInfo.convert(frame, result);
      },
      getChapter: (final String url, final Locale locale) async {
        final FubukiValue value = await frame.callValue(
          getChapter,
          <FubukiValue>[
            FubukiStringValue(url),
            FubukiStringValue(locale.toCodeString()),
          ],
        ).unwrapUnsafe();
        final FubukiValue result = await value.awaited();
        return converter.pageInfo.convertMany(frame, result);
      },
      getPage: (final String url, final Locale locale) async {
        final FubukiValue value = await frame.callValue(
          getPage,
          <FubukiValue>[
            FubukiStringValue(url),
            FubukiStringValue(locale.toCodeString()),
          ],
        ).unwrapUnsafe();
        final FubukiValue result = await value.awaited();
        return converter.imageDescriber.convert(frame, result);
      },
    );
  }
}

extension TenkaFubukiMangaExtractorConverter on TenkaFubukiConverter {
  TenkaFubukiMangaExtractorConvertable get mangaExtractor =>
      TenkaFubukiMangaExtractorConvertable(this);
}
