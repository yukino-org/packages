import 'package:baize_vm/baize_vm.dart';
import 'package:tenka/tenka.dart';

class TenkaBaizeEpisodeStreamConvertable
    extends TenkaBaizeConvertable<EpisodeStream> {
  TenkaBaizeEpisodeStreamConvertable(super.converter);

  @override
  EpisodeStream convert(
    final BaizeCallFrame frame,
    final BaizeValue value,
  ) {
    final BaizePrimitiveObjectValue casted = value.cast();
    final BaizeStringValue url =
        casted.getNamedProperty(TenkaBaizeConverter.kUrl);
    final BaizeStringValue quality =
        casted.getNamedProperty(TenkaBaizeConverter.kQuality);
    final BaizeValue headers =
        casted.getNamedProperty(TenkaBaizeConverter.kHeaders);
    final BaizeValue locale =
        casted.getNamedProperty(TenkaBaizeConverter.kLocale);

    return EpisodeStream(
      url: url.value,
      quality: Quality.parse(quality.value),
      headers: converter.headers.convert(frame, headers),
      locale: converter.locale.convert(frame, locale),
    );
  }
}

extension TenkaBaizeEpisodeStreamConverter on TenkaBaizeConverter {
  TenkaBaizeEpisodeStreamConvertable get episodeStream =>
      TenkaBaizeEpisodeStreamConvertable(this);
}
