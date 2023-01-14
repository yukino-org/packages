import 'package:fubuki_vm/fubuki_vm.dart';
import 'package:tenka/tenka.dart';
import 'exports.dart';

class TenkaFubukiAnimeInfoConvertable
    extends TenkaFubukiConvertable<AnimeInfo> {
  TenkaFubukiAnimeInfoConvertable(super.converter);

  @override
  AnimeInfo convert(final FubukiValue value) {
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
      episodes: converter.episodeInfo.convertMany(episodes),
      locale: converter.locale.convert(locale),
      availableLocales: converter.locale.convertMany(availableLocales),
      thumbnail: converter.imageDescriber.maybeConvert(thumbnail),
    );
  }
}

extension TenkaFubukiAnimeInfoConverter on TenkaFubukiConverter {
  TenkaFubukiAnimeInfoConvertable get animeInfo =>
      TenkaFubukiAnimeInfoConvertable(this);
}
