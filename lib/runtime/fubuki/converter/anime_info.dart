import 'package:fubuki_vm/fubuki_vm.dart';
import 'package:tenka/tenka.dart';

class TenkaFubukiAnimeInfoConvertable
    extends TenkaFubukiConvertable<AnimeInfo> {
  TenkaFubukiAnimeInfoConvertable(super.converter);

  @override
  AnimeInfo convert(
    final FubukiCallFrame frame,
    final FubukiValue value,
  ) {
    final FubukiPrimitiveObjectValue casted = value.cast();
    final FubukiStringValue title =
        casted.getNamedProperty(TenkaFubukiConverter.kTitle);
    final FubukiStringValue url =
        casted.getNamedProperty(TenkaFubukiConverter.kUrl);
    final FubukiValue episodes =
        casted.getNamedProperty(TenkaFubukiConverter.kEpisodes);
    final FubukiValue locale =
        casted.getNamedProperty(TenkaFubukiConverter.kLocale);
    final FubukiValue availableLocales =
        casted.getNamedProperty(TenkaFubukiConverter.kAvailableLocales);
    final FubukiValue thumbnail =
        casted.getNamedProperty(TenkaFubukiConverter.kThumbnail);

    return AnimeInfo(
      title: title.value,
      url: url.value,
      episodes: converter.episodeInfo.convertMany(frame, episodes),
      locale: converter.locale.convert(frame, locale),
      availableLocales: converter.locale.convertMany(frame, availableLocales),
      thumbnail: converter.imageDescriber.maybeConvert(frame, thumbnail),
    );
  }
}

extension TenkaFubukiAnimeInfoConverter on TenkaFubukiConverter {
  TenkaFubukiAnimeInfoConvertable get animeInfo =>
      TenkaFubukiAnimeInfoConvertable(this);
}
