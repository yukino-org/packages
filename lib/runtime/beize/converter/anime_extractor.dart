import 'package:beize_vm/beize_vm.dart';
import 'package:tenka/tenka.dart';
import 'package:utilx/locale.dart';
import '../helpers/frame.dart';

class TenkaBeizeAnimeExtractorConvertable
    extends TenkaBeizeConvertable<AnimeExtractor> {
  TenkaBeizeAnimeExtractorConvertable(super.converter);

  @override
  AnimeExtractor convert(
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
    final BeizeFunctionValue getSource =
        casted.getNamedProperty(TenkaBeizeConverter.kGetSource);

    return AnimeExtractor(
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
        return converter.animeInfo.convert(frame, result);
      },
      getSource: (final String url, final Locale locale) async {
        final BeizeValue result = await frame.callValueAsyncUnwrapUnsafe(
          getSource,
          <BeizeValue>[
            BeizeStringValue(url),
            BeizeStringValue(locale.toCodeString()),
          ],
        );
        return converter.episodeSource.convert(frame, result);
      },
    );
  }
}

extension TenkaBeizeAnimeExtractorConverter on TenkaBeizeConverter {
  TenkaBeizeAnimeExtractorConvertable get animeExtractor =>
      TenkaBeizeAnimeExtractorConvertable(this);
}
