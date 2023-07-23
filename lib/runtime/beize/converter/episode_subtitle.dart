import 'package:beize_vm/beize_vm.dart';
import 'package:tenka/tenka.dart';

class TenkaBeizeEpisodeSubtitleConvertable
    extends TenkaBeizeConvertable<EpisodeSubtitle> {
  TenkaBeizeEpisodeSubtitleConvertable(super.converter);

  @override
  EpisodeSubtitle convert(
    final BeizeCallFrame frame,
    final BeizeValue value,
  ) {
    final BeizePrimitiveObjectValue casted = value.cast();
    final BeizeStringValue url =
        casted.getNamedProperty(TenkaBeizeConverter.kUrl);
    final BeizeValue headers =
        casted.getNamedProperty(TenkaBeizeConverter.kHeaders);
    final BeizeValue locale =
        casted.getNamedProperty(TenkaBeizeConverter.kLocale);

    return EpisodeSubtitle(
      url: url.value,
      headers: converter.headers.convert(frame, headers),
      locale: converter.locale.convert(frame, locale),
    );
  }
}

extension TenkaBeizeEpisodeSubtitleConverter on TenkaBeizeConverter {
  TenkaBeizeEpisodeSubtitleConvertable get episodeSubtitle =>
      TenkaBeizeEpisodeSubtitleConvertable(this);
}
