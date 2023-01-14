import 'package:fubuki_vm/fubuki_vm.dart';
import 'package:tenka/tenka.dart';
import 'exports.dart';

class TenkaFubukiEpisodeSourceConvertable
    extends TenkaFubukiConvertable<EpisodeSource> {
  TenkaFubukiEpisodeSourceConvertable(super.converter);

  @override
  EpisodeSource convert(final FubukiValue value) {
    final FubukiPrimitiveObjectValue casted = value.cast();
    final FubukiStringValue url =
        casted.getNamedProperty(TenkaFubukiConverter.kUrl);
    final FubukiStringValue quality =
        casted.getNamedProperty(TenkaFubukiConverter.kQuality);
    final FubukiValue headers =
        casted.getNamedProperty(TenkaFubukiConverter.kHeaders);
    final FubukiValue locale =
        casted.getNamedProperty(TenkaFubukiConverter.kLocale);

    return EpisodeSource(
      url: url.value,
      quality: Quality.parse(quality.value),
      headers: converter.headers.convert(headers),
      locale: converter.locale.convert(locale),
    );
  }
}

extension TenkaFubukiEpisodeSourceConverter on TenkaFubukiConverter {
  TenkaFubukiEpisodeSourceConvertable get episodeSource =>
      TenkaFubukiEpisodeSourceConvertable(this);
}
