import 'package:baize_vm/baize_vm.dart';
import 'package:tenka/tenka.dart';

class TenkaBaizeEpisodeSubtitleConvertable
    extends TenkaBaizeConvertable<EpisodeSubtitle> {
  TenkaBaizeEpisodeSubtitleConvertable(super.converter);

  @override
  EpisodeSubtitle convert(
    final BaizeCallFrame frame,
    final BaizeValue value,
  ) {
    final BaizePrimitiveObjectValue casted = value.cast();
    final BaizeStringValue url =
        casted.getNamedProperty(TenkaBaizeConverter.kUrl);
    final BaizeValue headers =
        casted.getNamedProperty(TenkaBaizeConverter.kHeaders);
    final BaizeValue locale =
        casted.getNamedProperty(TenkaBaizeConverter.kLocale);

    return EpisodeSubtitle(
      url: url.value,
      headers: converter.headers.convert(frame, headers),
      locale: converter.locale.convert(frame, locale),
    );
  }
}

extension TenkaBaizeEpisodeSubtitleConverter on TenkaBaizeConverter {
  TenkaBaizeEpisodeSubtitleConvertable get episodeSubtitle =>
      TenkaBaizeEpisodeSubtitleConvertable(this);
}
