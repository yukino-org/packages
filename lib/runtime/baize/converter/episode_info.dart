import 'package:baize_vm/baize_vm.dart';
import 'package:tenka/tenka.dart';

class TenkaBaizeEpisodeInfoConvertable
    extends TenkaBaizeConvertable<EpisodeInfo> {
  TenkaBaizeEpisodeInfoConvertable(super.converter);

  @override
  EpisodeInfo convert(
    final BaizeCallFrame frame,
    final BaizeValue value,
  ) {
    final BaizePrimitiveObjectValue casted = value.cast();
    final BaizeStringValue episode =
        casted.getNamedProperty(TenkaBaizeConverter.kEpisode);
    final BaizeStringValue url =
        casted.getNamedProperty(TenkaBaizeConverter.kUrl);
    final BaizeValue locale =
        casted.getNamedProperty(TenkaBaizeConverter.kLocale);

    return EpisodeInfo(
      episode: episode.value,
      url: url.value,
      locale: converter.locale.convert(frame, locale),
    );
  }
}

extension TenkaBaizeEpisodeInfoConverter on TenkaBaizeConverter {
  TenkaBaizeEpisodeInfoConvertable get episodeInfo =>
      TenkaBaizeEpisodeInfoConvertable(this);
}
