import 'package:beize_vm/beize_vm.dart';
import 'package:tenka/tenka.dart';

class TenkaBeizeEpisodeInfoConvertable
    extends TenkaBeizeConvertable<EpisodeInfo> {
  TenkaBeizeEpisodeInfoConvertable(super.converter);

  @override
  EpisodeInfo convert(
    final BeizeCallFrame frame,
    final BeizeValue value,
  ) {
    final BeizePrimitiveObjectValue casted = value.cast();
    final BeizeStringValue episode =
        casted.getNamedProperty(TenkaBeizeConverter.kEpisode);
    final BeizeStringValue url =
        casted.getNamedProperty(TenkaBeizeConverter.kUrl);
    final BeizeValue locale =
        casted.getNamedProperty(TenkaBeizeConverter.kLocale);

    return EpisodeInfo(
      episode: episode.value,
      url: url.value,
      locale: converter.locale.convert(frame, locale),
    );
  }
}

extension TenkaBeizeEpisodeInfoConverter on TenkaBeizeConverter {
  TenkaBeizeEpisodeInfoConvertable get episodeInfo =>
      TenkaBeizeEpisodeInfoConvertable(this);
}
