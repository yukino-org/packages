import 'package:beize_vm/beize_vm.dart';
import 'package:tenka/tenka.dart';

class TenkaBeizeAnimeInfoConvertable extends TenkaBeizeConvertable<AnimeInfo> {
  TenkaBeizeAnimeInfoConvertable(super.converter);

  @override
  AnimeInfo convert(
    final BeizeCallFrame frame,
    final BeizeValue value,
  ) {
    final BeizePrimitiveObjectValue casted = value.cast();
    final BeizeStringValue title =
        casted.getNamedProperty(TenkaBeizeConverter.kTitle);
    final BeizeStringValue url =
        casted.getNamedProperty(TenkaBeizeConverter.kUrl);
    final BeizeValue episodes =
        casted.getNamedProperty(TenkaBeizeConverter.kEpisodes);
    final BeizeValue locale =
        casted.getNamedProperty(TenkaBeizeConverter.kLocale);
    final BeizeValue availableLocales =
        casted.getNamedProperty(TenkaBeizeConverter.kAvailableLocales);
    final BeizeValue thumbnail =
        casted.getNamedProperty(TenkaBeizeConverter.kThumbnail);

    return AnimeInfo(
      title: title.value,
      url: url.value,
      episodes: converter.episodeInfo.convertMany(frame, episodes),
      locale: converter.locale.convert(frame, locale),
      availableLocales: converter.locale.convertMany(frame, availableLocales),
      thumbnail: converter.imageDescriber.maybeConvert(frame, thumbnail),
    );
  }
}

extension TenkaBeizeAnimeInfoConverter on TenkaBeizeConverter {
  TenkaBeizeAnimeInfoConvertable get animeInfo =>
      TenkaBeizeAnimeInfoConvertable(this);
}
