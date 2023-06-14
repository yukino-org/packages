import 'package:baize_vm/baize_vm.dart';
import 'package:tenka/tenka.dart';

class TenkaBaizeChapterInfoConvertable
    extends TenkaBaizeConvertable<ChapterInfo> {
  TenkaBaizeChapterInfoConvertable(super.converter);

  @override
  ChapterInfo convert(
    final BaizeCallFrame frame,
    final BaizeValue value,
  ) {
    final BaizePrimitiveObjectValue casted = value.cast();
    final BaizeStringValue chapter =
        casted.getNamedProperty(TenkaBaizeConverter.kChapter);
    final BaizeStringValue url =
        casted.getNamedProperty(TenkaBaizeConverter.kUrl);
    final BaizeValue locale =
        casted.getNamedProperty(TenkaBaizeConverter.kLocale);
    final BaizeValue title =
        casted.getNamedProperty(TenkaBaizeConverter.kTitle);
    final BaizeValue volume =
        casted.getNamedProperty(TenkaBaizeConverter.kVolume);

    return ChapterInfo(
      chapter: chapter.value,
      url: url.value,
      locale: converter.locale.convert(frame, locale),
      title: converter.nullableString.convert(frame, title),
      volume: converter.nullableString.convert(frame, volume),
    );
  }
}

extension TenkaBaizeChapterInfoConverter on TenkaBaizeConverter {
  TenkaBaizeChapterInfoConvertable get chapterInfo =>
      TenkaBaizeChapterInfoConvertable(this);
}
