import 'package:beize_vm/beize_vm.dart';
import 'package:tenka/tenka.dart';

class TenkaBeizeMangaInfoConvertable extends TenkaBeizeConvertable<MangaInfo> {
  TenkaBeizeMangaInfoConvertable(super.converter);

  @override
  MangaInfo convert(
    final BeizeCallFrame frame,
    final BeizeValue value,
  ) {
    final BeizePrimitiveObjectValue casted = value.cast();
    final BeizeStringValue title =
        casted.getNamedProperty(TenkaBeizeConverter.kTitle);
    final BeizeStringValue url =
        casted.getNamedProperty(TenkaBeizeConverter.kUrl);
    final BeizeValue chapters =
        casted.getNamedProperty(TenkaBeizeConverter.kChapters);
    final BeizeStringValue locale =
        casted.getNamedProperty(TenkaBeizeConverter.kLocale);
    final BeizeValue availableLocales =
        casted.getNamedProperty(TenkaBeizeConverter.kAvailableLocales);
    final BeizeValue thumbnail =
        casted.getNamedProperty(TenkaBeizeConverter.kThumbnail);

    return MangaInfo(
      title: title.value,
      url: url.value,
      chapters: converter.chapterInfo.convertMany(frame, chapters),
      locale: converter.locale.convert(frame, locale),
      availableLocales: converter.locale.convertMany(frame, availableLocales),
      thumbnail: converter.imageDescriber.maybeConvert(frame, thumbnail),
    );
  }
}

extension TenkaBeizeMangaInfoConverter on TenkaBeizeConverter {
  TenkaBeizeMangaInfoConvertable get mangaInfo =>
      TenkaBeizeMangaInfoConvertable(this);
}
