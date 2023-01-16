import 'package:fubuki_vm/fubuki_vm.dart';
import 'package:tenka/tenka.dart';

class TenkaFubukiChapterInfoConvertable
    extends TenkaFubukiConvertable<ChapterInfo> {
  TenkaFubukiChapterInfoConvertable(super.converter);

  @override
  ChapterInfo convert(
    final FubukiCallFrame frame,
    final FubukiValue value,
  ) {
    final FubukiPrimitiveObjectValue casted = value.cast();
    final FubukiStringValue chapter =
        casted.getNamedProperty(TenkaFubukiConverter.kChapter);
    final FubukiStringValue url =
        casted.getNamedProperty(TenkaFubukiConverter.kUrl);
    final FubukiValue locale =
        casted.getNamedProperty(TenkaFubukiConverter.kLocale);
    final FubukiValue title =
        casted.getNamedProperty(TenkaFubukiConverter.kTitle);
    final FubukiValue volume =
        casted.getNamedProperty(TenkaFubukiConverter.kVolume);

    return ChapterInfo(
      chapter: chapter.value,
      url: url.value,
      locale: converter.locale.convert(frame, locale),
      title: converter.nullableString.convert(frame, title),
      volume: converter.nullableString.convert(frame, volume),
    );
  }
}

extension TenkaFubukiChapterInfoConverter on TenkaFubukiConverter {
  TenkaFubukiChapterInfoConvertable get chapterInfo =>
      TenkaFubukiChapterInfoConvertable(this);
}
