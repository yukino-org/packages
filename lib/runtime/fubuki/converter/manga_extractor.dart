import 'package:fubuki_vm/fubuki_vm.dart';
import 'package:tenka/tenka.dart';
import 'package:utilx/locale.dart';
import 'exports.dart';

class TenkaFubukiMangaExtractorConvertable
    extends TenkaFubukiConvertable<MangaExtractor> {
  TenkaFubukiMangaExtractorConvertable(super.converter);

  @override
  MangaExtractor convert(final FubukiValue value) {
    final FubukiPrimitiveObjectValue casted = value.cast();
    final FubukiValue defaultLocale =
        casted.getNamedProperty(TenkaFubukiConverter.kDefaultLocale);
    final FubukiFunctionValue search =
        casted.getNamedProperty(TenkaFubukiConverter.kSearch);
    final FubukiFunctionValue getInfo =
        casted.getNamedProperty(TenkaFubukiConverter.kGetInfo);

    return MangaExtractor(
      defaultLocale: converter.locale.convert(defaultLocale),
      search: (final String terms, final Locale locale) async {
        final FubukiValue result = await search.callInVM(
          converter.runtime.vm,
          <FubukiValue>[
            FubukiStringValue(terms),
            FubukiStringValue(locale.toCodeString()),
          ],
        ).unwrapUnsafe();
        return converter.searchInfo.convertMany(result);
      },
      getInfo: (final String url, final Locale locale) async {
        final FubukiValue result = await getInfo.callInVM(
          converter.runtime.vm,
          <FubukiValue>[
            FubukiStringValue(url),
            FubukiStringValue(locale.toCodeString()),
          ],
        ).unwrapUnsafe();
        return converter.mangaInfo.convert(result);
      },
      getChapter: (final String url, final Locale locale) async {
        final FubukiValue result = await getInfo.callInVM(
          converter.runtime.vm,
          <FubukiValue>[
            FubukiStringValue(url),
            FubukiStringValue(locale.toCodeString()),
          ],
        ).unwrapUnsafe();
        return converter.pageInfo.convertMany(result);
      },
      getPage: (final String url, final Locale locale) async {
        final FubukiValue result = await getInfo.callInVM(
          converter.runtime.vm,
          <FubukiValue>[
            FubukiStringValue(url),
            FubukiStringValue(locale.toCodeString()),
          ],
        ).unwrapUnsafe();
        return converter.imageDescriber.convert(result);
      },
    );
  }
}

extension TenkaFubukiMangaExtractorConverter on TenkaFubukiConverter {
  TenkaFubukiMangaExtractorConvertable get mangaExtractor =>
      TenkaFubukiMangaExtractorConvertable(this);
}
