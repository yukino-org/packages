import 'package:fubuki_vm/fubuki_vm.dart';
import 'package:tenka/tenka.dart';

class TenkaFubukiEpisodeInfoConvertable
    extends TenkaFubukiConvertable<EpisodeInfo> {
  TenkaFubukiEpisodeInfoConvertable(super.converter);

  @override
  EpisodeInfo convert(
    final FubukiCallFrame frame,
    final FubukiValue value,
  ) {
    final FubukiPrimitiveObjectValue casted = value.cast();
    final FubukiStringValue episode =
        casted.getNamedProperty(TenkaFubukiConverter.kEpisode);
    final FubukiStringValue url =
        casted.getNamedProperty(TenkaFubukiConverter.kUrl);
    final FubukiValue locale =
        casted.getNamedProperty(TenkaFubukiConverter.kLocale);

    return EpisodeInfo(
      episode: episode.value,
      url: url.value,
      locale: converter.locale.convert(frame, locale),
    );
  }
}

extension TenkaFubukiEpisodeInfoConverter on TenkaFubukiConverter {
  TenkaFubukiEpisodeInfoConvertable get episodeInfo =>
      TenkaFubukiEpisodeInfoConvertable(this);
}
