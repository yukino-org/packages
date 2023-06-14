import 'package:baize_vm/baize_vm.dart';
import 'package:tenka/tenka.dart';

class TenkaBaizeMangaInfoConvertable extends TenkaBaizeConvertable<MangaInfo> {
  TenkaBaizeMangaInfoConvertable(super.converter);

  @override
  MangaInfo convert(
    final BaizeCallFrame frame,
    final BaizeValue value,
  ) {
    final BaizePrimitiveObjectValue casted = value.cast();
    final BaizeStringValue title =
        casted.getNamedProperty(TenkaBaizeConverter.kTitle);
    final BaizeStringValue url =
        casted.getNamedProperty(TenkaBaizeConverter.kUrl);
    final BaizeValue chapters =
        casted.getNamedProperty(TenkaBaizeConverter.kChapters);
    final BaizeStringValue locale =
        casted.getNamedProperty(TenkaBaizeConverter.kLocale);
    final BaizeValue availableLocales =
        casted.getNamedProperty(TenkaBaizeConverter.kAvailableLocales);
    final BaizeValue thumbnail =
        casted.getNamedProperty(TenkaBaizeConverter.kThumbnail);

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

extension TenkaBaizeMangaInfoConverter on TenkaBaizeConverter {
  TenkaBaizeMangaInfoConvertable get mangaInfo =>
      TenkaBaizeMangaInfoConvertable(this);
}
