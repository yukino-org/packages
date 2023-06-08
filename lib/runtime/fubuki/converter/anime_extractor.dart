import 'package:fubuki_vm/fubuki_vm.dart';
import 'package:tenka/tenka.dart';
import 'package:utilx/locale.dart';

class TenkaFubukiAnimeExtractorConvertable
    extends TenkaFubukiConvertable<AnimeExtractor> {
  TenkaFubukiAnimeExtractorConvertable(super.converter);

  @override
  AnimeExtractor convert(
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
    final FubukiFunctionValue getSource =
        casted.getNamedProperty(TenkaFubukiConverter.kGetSource);

    return AnimeExtractor(
      defaultLocale: converter.locale.convert(frame, defaultLocale),
      search: (final String terms, final Locale locale) async {
        final FubukiValue result = await frame.callValue(
          search,
          <FubukiValue>[
            FubukiStringValue(terms),
            FubukiStringValue(locale.toCodeString()),
          ],
        ).unwrapUnsafe();
        return converter.searchInfo.convertMany(frame, result);
      },
      getInfo: (final String url, final Locale locale) async {
        final FubukiValue result = await frame.callValue(
          getInfo,
          <FubukiValue>[
            FubukiStringValue(url),
            FubukiStringValue(locale.toCodeString()),
          ],
        ).unwrapUnsafe();
        return converter.animeInfo.convert(frame, result);
      },
      getSource: (final String url, final Locale locale) async {
        final FubukiValue result = await frame.callValue(
          getSource,
          <FubukiValue>[
            FubukiStringValue(url),
            FubukiStringValue(locale.toCodeString()),
          ],
        ).unwrapUnsafe();
        return converter.episodeSource.convert(frame, result);
      },
    );
  }
}

extension TenkaFubukiAnimeExtractorConverter on TenkaFubukiConverter {
  TenkaFubukiAnimeExtractorConvertable get animeExtractor =>
      TenkaFubukiAnimeExtractorConvertable(this);
}
