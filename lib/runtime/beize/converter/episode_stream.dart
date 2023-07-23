import 'package:beize_vm/beize_vm.dart';
import 'package:tenka/tenka.dart';

class TenkaBeizeEpisodeStreamConvertable
    extends TenkaBeizeConvertable<EpisodeStream> {
  TenkaBeizeEpisodeStreamConvertable(super.converter);

  @override
  EpisodeStream convert(
    final BeizeCallFrame frame,
    final BeizeValue value,
  ) {
    final BeizePrimitiveObjectValue casted = value.cast();
    final BeizeStringValue url =
        casted.getNamedProperty(TenkaBeizeConverter.kUrl);
    final BeizeStringValue quality =
        casted.getNamedProperty(TenkaBeizeConverter.kQuality);
    final BeizeValue headers =
        casted.getNamedProperty(TenkaBeizeConverter.kHeaders);
    final BeizeValue locale =
        casted.getNamedProperty(TenkaBeizeConverter.kLocale);

    return EpisodeStream(
      url: url.value,
      quality: Quality.parse(quality.value),
      headers: converter.headers.convert(frame, headers),
      locale: converter.locale.convert(frame, locale),
    );
  }
}

extension TenkaBeizeEpisodeStreamConverter on TenkaBeizeConverter {
  TenkaBeizeEpisodeStreamConvertable get episodeStream =>
      TenkaBeizeEpisodeStreamConvertable(this);
}
