import 'package:fubuki_vm/fubuki_vm.dart';
import 'package:tenka/tenka.dart';

class TenkaFubukiEpisodeStreamConvertable
    extends TenkaFubukiConvertable<EpisodeStream> {
  TenkaFubukiEpisodeStreamConvertable(super.converter);

  @override
  EpisodeStream convert(
    final FubukiCallFrame frame,
    final FubukiValue value,
  ) {
    final FubukiPrimitiveObjectValue casted = value.cast();
    final FubukiStringValue url =
        casted.getNamedProperty(TenkaFubukiConverter.kUrl);
    final FubukiStringValue quality =
        casted.getNamedProperty(TenkaFubukiConverter.kQuality);
    final FubukiValue headers =
        casted.getNamedProperty(TenkaFubukiConverter.kHeaders);
    final FubukiValue locale =
        casted.getNamedProperty(TenkaFubukiConverter.kLocale);

    return EpisodeStream(
      url: url.value,
      quality: Quality.parse(quality.value),
      headers: converter.headers.convert(frame, headers),
      locale: converter.locale.convert(frame, locale),
    );
  }
}

extension TenkaFubukiEpisodeStreamConverter on TenkaFubukiConverter {
  TenkaFubukiEpisodeStreamConvertable get episodeStream =>
      TenkaFubukiEpisodeStreamConvertable(this);
}
