import 'package:fubuki_vm/fubuki_vm.dart';
import 'package:tenka/tenka.dart';

class TenkaFubukiEpisodeSubtitleConvertable
    extends TenkaFubukiConvertable<EpisodeSubtitle> {
  TenkaFubukiEpisodeSubtitleConvertable(super.converter);

  @override
  EpisodeSubtitle convert(
    final FubukiCallFrame frame,
    final FubukiValue value,
  ) {
    final FubukiPrimitiveObjectValue casted = value.cast();
    final FubukiStringValue url =
        casted.getNamedProperty(TenkaFubukiConverter.kUrl);
    final FubukiValue headers =
        casted.getNamedProperty(TenkaFubukiConverter.kHeaders);
    final FubukiValue locale =
        casted.getNamedProperty(TenkaFubukiConverter.kLocale);

    return EpisodeSubtitle(
      url: url.value,
      headers: converter.headers.convert(frame, headers),
      locale: converter.locale.convert(frame, locale),
    );
  }
}

extension TenkaFubukiEpisodeSubtitleConverter on TenkaFubukiConverter {
  TenkaFubukiEpisodeSubtitleConvertable get episodeSubtitle =>
      TenkaFubukiEpisodeSubtitleConvertable(this);
}
