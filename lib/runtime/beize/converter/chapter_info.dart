import 'package:beize_vm/beize_vm.dart';
import 'package:tenka/tenka.dart';

class TenkaBeizeChapterInfoConvertable
    extends TenkaBeizeConvertable<ChapterInfo> {
  TenkaBeizeChapterInfoConvertable(super.converter);

  @override
  ChapterInfo convert(
    final BeizeCallFrame frame,
    final BeizeValue value,
  ) {
    final BeizePrimitiveObjectValue casted = value.cast();
    final BeizeStringValue chapter =
        casted.getNamedProperty(TenkaBeizeConverter.kChapter);
    final BeizeStringValue url =
        casted.getNamedProperty(TenkaBeizeConverter.kUrl);
    final BeizeValue locale =
        casted.getNamedProperty(TenkaBeizeConverter.kLocale);
    final BeizeValue title =
        casted.getNamedProperty(TenkaBeizeConverter.kTitle);
    final BeizeValue volume =
        casted.getNamedProperty(TenkaBeizeConverter.kVolume);

    return ChapterInfo(
      chapter: chapter.value,
      url: url.value,
      locale: converter.locale.convert(frame, locale),
      title: converter.nullableString.convert(frame, title),
      volume: converter.nullableString.convert(frame, volume),
    );
  }
}

extension TenkaBeizeChapterInfoConverter on TenkaBeizeConverter {
  TenkaBeizeChapterInfoConvertable get chapterInfo =>
      TenkaBeizeChapterInfoConvertable(this);
}
