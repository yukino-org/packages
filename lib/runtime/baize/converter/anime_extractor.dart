import 'package:baize_vm/baize_vm.dart';
import 'package:tenka/tenka.dart';
import 'package:utilx/locale.dart';

class TenkaBaizeAnimeExtractorConvertable
    extends TenkaBaizeConvertable<AnimeExtractor> {
  TenkaBaizeAnimeExtractorConvertable(super.converter);

  @override
  AnimeExtractor convert(
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
    final BaizeFunctionValue getSource =
        casted.getNamedProperty(TenkaBaizeConverter.kGetSource);

    return AnimeExtractor(
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
        return converter.animeInfo.convert(frame, result);
      },
      getSource: (final String url, final Locale locale) async {
        final BaizeValue result = await frame.callValue(
          getSource,
          <BaizeValue>[
            BaizeStringValue(url),
            BaizeStringValue(locale.toCodeString()),
          ],
        ).unwrapUnsafe();
        return converter.episodeSource.convert(frame, result);
      },
    );
  }
}

extension TenkaBaizeAnimeExtractorConverter on TenkaBaizeConverter {
  TenkaBaizeAnimeExtractorConvertable get animeExtractor =>
      TenkaBaizeAnimeExtractorConvertable(this);
}
